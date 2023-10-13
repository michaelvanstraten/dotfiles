#!/bin/bash

# Configuration options
DOTFILES_REPO="https://github.com/michaelvanstraten/dotfiles.git"
BREWFILE="$HOME/.homebrew/Brewfile"
BACKUP_DIR="$HOME/.dotfiles-backup"
LOG_FILE="$HOME/.dotfiles-install.log"

# ANSI escape codes for colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

# Function to print colored messages
print_message() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${RESET}"
}

# Function to print an error message and exit
exit_with_error() {
    print_message "${RED}" "Error: $1"
    exit 1
}

# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Define a function to work with dotfiles
dotfiles() {
    git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

# Function to confirm actions interactively
confirm_action() {
    local prompt="$1"
    read -r -p "$prompt (y/N): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to install Homebrew if not installed
install_homebrew() {
    if ! command_exists "brew"; then
        print_message "${YELLOW}" "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' | tee -a "$HOME/.zprofile" "$HOME/.bash_profile" "$HOME/.config/fish/conf.d/homebrew.fish"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        print_message "${GREEN}" "Homebrew is installed."
    else
        print_message "${GREEN}" "Homebrew is already installed."
    fi
}

# Function to handle dotfiles installation
install_dotfiles() {
    # Clone dotfiles repository
    if [ -d "$HOME/.dotfiles" ]; then
        print_message "${YELLOW}" "Dotfiles repository already exists. Skipping clone."
    else
        git clone --bare "$DOTFILES_REPO" "$HOME/.dotfiles" >> "$LOG_FILE" 2>&1
        print_message "${GREEN}" "Dotfiles repository cloned."
    fi

    # Handle existing dotfiles backup
    if [ -d "$BACKUP_DIR" ]; then
        confirm_action "There already exists a backup of your dotfiles, proceeding would delete that backup." || exit_with_error "Backup directory '$BACKUP_DIR' already exists. Aborting to prevent data loss."
        rm -r "$BACKUP_DIR"
    fi

    # Attempt to checkout dotfiles
    if [ -d "$HOME/.dotfiles" ]; then
        mkdir -p "$BACKUP_DIR"
        dotfiles checkout 2>&1 | while read -r file; do
            if echo "$file" | grep -q "already exists"; then
                print_message "${RED}" "Backing up pre-existing dotfiles."
                dotfiles checkout 2>&1 | awk '/\s+\./ {print $1}' | xargs -I{} mv {} "$BACKUP_DIR/{}"
                break
            fi
        done
    fi

    # Set status.showUntrackedFiles to no to ignore untracked files
    dotfiles config status.showUntrackedFiles no

    # Hide readme.md if on macOS
    if [ "$(uname -s)" == "Darwin" ]; then
        chflags hidden "$HOME/readme.md"
    fi

    print_message "${GREEN}" "Dotfiles installation completed. Check $LOG_FILE for details."
}

# Main script
if [ -z "$BASH_SOURCE" ]; then
    install_homebrew
    install_dotfiles

    # Install Packages using Brewfile
    if [ -f "$BREWFILE" ] && confirm_action "Install homebrew packages from Brewfile"; then
        confirm_action "Edit Brewfile before installing" && $EDITOR "$BREWFILE"
        print_message "${GREEN}" "Installing packages from Brewfile..."
        brew bundle --file "$BREWFILE" >> "$LOG_FILE" 2>&1
    else
        print_message "${RED}" "Brewfile not found. No packages to install."
    fi

    if command_exists "fish" && confirm_action "Set fish as the default shell"; then
        sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
        chsh -s /opt/homebrew/bin/fish
    fi

    # Install tmux plugin manager (tpm) if tmux is installed
    if command_exists "tmux"; then
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
fi
