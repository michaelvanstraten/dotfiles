#!/bin/sh

# Configuration options
: "${REMOTE:="https://github.com/michaelvanstraten/dotfiles.git"}"
: "${REMOTE_BRANCH:="master"}"
: "${BREW_BUNDLE:="$HOME/.homebrew/Brewfile"}"
: "${EDITOR:=vi}"

main() {
	# Check if OS is compatible.
	OS="$(uname)"
	if [ "${OS}" != "Linux" ] && [ "${OS}" != "Darwin" ]; then
		abort "This script is only supported on macOS and Linux."
	fi

	confirm_action "install Homebrew" && install_homebrew

	confirm_action "bootstrap dotfiles repository" && bootstrap_repo

	confirm_action "install homebrew bundle" && install_brew_bundle

	set_default_shell

	confirm_action "load OS-specific configuration" && load_os_config

	echo "Dotfiles Bootstrap completed."

	# Suggest logging out for settings to take effect
	if [ "$(uname -s)" = "Darwin" ] && confirm_action "Logout current user for some settings to take effect"; then
		osascript -e 'tell app "System Events" to log out'
	fi
}

# Installs Homebrew if not already installed
install_homebrew() {
	if ! command_exists "brew"; then
		print_heading "Installing Homebrew ..."

		check_dependencies "bash" "curl" "git"

		export NONINTERACTIVE
		ensure bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		unset NONINTERACTIVE

		case "$(uname -s)" in
		Darwin)
			brew_path="/opt/homebrew/bin/brew"
			;;
		Linux)
			if [ -d "$HOME/.linuxbrew" ]; then
				brew_path="$HOME/.linuxbrew/bin/brew"
			elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
				brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
			else
				abort "Linuxbrew not found in expected locations."
			fi
			;;
		esac

		# Set Homebrew environment
		eval "$("$brew_path" shellenv)"
	else
		echo "Homebrew is already installed."
	fi
}

# Install the provided Homebrew bundle
install_brew_bundle() {
	if [ -f "$BREW_BUNDLE" ]; then
		confirm_action "edit homebrew bundle before installing" --no-ci && $EDITOR "$BREW_BUNDLE"
		print_heading "Installing packages from Brewfile ..."
		brew bundle --file "$BREW_BUNDLE"
	else
		warn "brew bundle not found under $BREW_BUNDLE"
	fi
}

# Clone dotfiles repository if not already
bootstrap_repo() {
	export GIT_DIR="$HOME/.git"
	export GIT_WORKDIR="$HOME"

	print_heading "Bootstrapping dotfiles repository ..."

	check_dependencies "git"

	git init -b master
	git remote add origin "$REMOTE"
	ensure git fetch origin "$REMOTE_BRANCH"
	ensure git checkout -b master "origin/$REMOTE_BRANCH"
	ensure git submodule update --init --recursive

	# Hide readme.md if on macOS
	if [ "$(uname -s)" = "Darwin" ]; then
		chflags hidden "$HOME/readme.md"
	fi

	# Add remote sub-tree repositories
	if ! git remote | grep --quiet --ignore-case betterfox; then
		git remote add Betterfox https://github.com/yokoffing/Betterfox
	fi

	unset GIT_DIR
	unset GIT_WORKDIR
}

load_os_config() {
	os_config="$HOME/.scripts/sys/$(uname | tr '[:upper:]' '[:lower:]').sh"
	if [ -f "$os_config" ]; then
		. "$os_config"
	else
		echo "No os config found for $(uname)."
	fi
}

set_default_shell() {
	if command_exists "fish" && confirm_action "make fish your default shell"; then
		fish_path=$(command -v fish)
		echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
		chsh -s "$fish_path" "$USER"
	fi
}

# String formatters
if [ -t 1 ]; then
	tty_escape() { printf "\033[%sm" "$1"; }
else
	tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_blue="$(tty_mkbold 34)"
tty_yellow="$(tty_mkbold 33)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

print_heading() {
	printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$@"
}

warn() {
	printf "${tty_yellow}Warning${tty_reset}: %s\n" "$1" >&2
}

abort() {
	printf "${tty_red}Error${tty_reset}: %s\n" "$1" >&2
	exit 1
}

ensure() {
	if ! "$@"; then abort "command failed: $*"; fi
}

# Function to check if a command is available
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Function to confirm actions interactively
confirm_action() {
	# If we are run by CI test everything
	if [ -n "${CI-}" ]; then
		return 0
	fi

	printf "${tty_blue}Confirm:${tty_reset} %s (y/N): " "$1"
	read -r response
	if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
		return 0
	else
		return 1
	fi
}

check_dependencies() {
	for dep in "$@"; do
		if ! command_exists "$dep"; then
			abort "${tty_yellow}$dep${tty_reset} is a required dependency for this step. Please install it and run this script again."
		fi
	done
}

main "$@" || exit 1
