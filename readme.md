# My dotfiles

![Screenshot of Terminal](./.config/screenshot.png)

Welcome to my dotfiles repository, where I store configuration and setup files from my home directory. These dotfiles help me maintain a consistent and efficient environment across different systems.

> [!IMPORTANT]
> This repository is deprecated. Please refer to the [michaelvanstraten/systems](https://github.com/michaelvanstraten/systems) repository for the latest configurations and system management.

## Installation

```bash
bash -c "$(curl -sS https://raw.githubusercontent.com/michaelvanstraten/dotfiles/master/.scripts/bootstrap.sh)"
```

I'm currently working on documenting the installation process to make it easier for others to use my dotfiles. Stay tuned for updates!

## Individual Components

Here's a list of the key components and tools in my setup, along with their respective configuration files:

- **macOS Package Manager:** [Homebrew](https://brew.sh) - [Configuration](.homebrew/Brewfile)
- **Window Manager:** [Yabai](https://github.com/koekeishiya/yabai) - [Configuration](.config/yabai/yabairc)
- **Terminal Emulator:** [Alacritty](https://alacritty.org) - [Configuration](.config/alacritty/alacritty.toml)
- **Terminal Multiplexer:** [tmux](https://github.com/tmux/tmux/wiki) - [Configuration](.config/tmux/tmux.conf)
- **Shell:** [fish](https://fishshell.com) - [Configuration](.config/fish)
- **Editor:** [Neovim](https://neovim.io) - [Configuration](.config/nvim)
- **Font:** [Jetbrains Mono](https://www.jetbrains.com/lp/mono/)
- **Keyboard Customization:** [Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements) - [Configuration](.config/karabiner/)

Feel free to explore these configurations and adapt them to your own preferences. If you have any questions or suggestions, please don't hesitate to reach out!
