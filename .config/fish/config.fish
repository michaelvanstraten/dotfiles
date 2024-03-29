# Disable welcome message
set fish_greeting

# Set Neovim as the default editor
set -Ux EDITOR nvim

# Set common Linux tools config paths
set -Ux XDG_CONFIG_HOME "$HOME/.config"

# Set pyenv root directory
set -x PYENV_ROOT "$HOME/.pyenv"

# Prevent my self from my self (i recently `rm -rf` my home directory)
alias rm="rm -i"

# Basic abbreviations
abbr -a c clear
abbr -a b brew
abbr -a vim nvim
abbr -a npm pnpm

# Abbreviation for creating a new tmux session with the name of the current directory
abbr -a tn 'tmux new -s (pwd | sed "s/.*\///g")'

# Kubectl abbreviations
abbr -a k kubectl
abbr -a kg "kubectl get"
abbr -a kl "kubectl logs"

# Git abbreviations
abbr -a gs "git status"
abbr -a gl "git log"
abbr -a gc "git clone"
abbr -a gr "git rebase"

# moz-phab abbreviations
abbr -a mz "moz-phab"

# Replace "ls" with "eza" if available
if command -q eza
    abbr -a l eza
    abbr -a ls eza
    abbr -a la "eza -a"
    abbr -a ll "eza -l"
    abbr -a lla "eza -la"
else
    abbr -a l ls
    abbr -a la "ls -a"
    abbr -a ll "ls -l"
    abbr -a lla "ls -la"
end

# Setup zoxide
if command -q zoxide
    zoxide init fish | source
end

# Initialize pyenv
if command -q pyenv
    pyenv init - | source
end

# Initialize starship prompt
if command -q starship
    starship init fish | source
end

# Set Go workspace and add Go binary path to the PATH
set -gx GOPATH "$HOME/.go"
if command -q go
    fish_add_path "$HOME/.go/bin/"
end

# Add ~/.local/bin to the PATH
fish_add_path "$HOME/.local/bin"

# Setup smart tmux session manager
fish_add_path "$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin"

# Setup krew (Krew is the plugin manager for kubectl command-line tool)
fish_add_path "$HOME/.krew/bin"

# Setup podman docker replacement
if command -q podman
     set -gx DOCKER_HOST "unix://$HOME/.local/share/containers/podman/machine/qemu/podman.sock"
end
