# Dotfiles

This repository contains configuration files and scripts to set up and manage my development environment. It includes tools, configurations, and automation for a streamlined setup process.

## Features

- **Automated Installation**: Scripts to install essential tools and configurations.
- **Symbolic Linking**: Uses `stow` to generate links between dotfiles and configurations.
- **Customizable**: Easily update and extend configurations for tools like `zsh`, `neovim`, and more.

## Prerequisites

- **Linux**: This setup is designed for Linux-based systems: Pop-os and Arch Linux. _not fully tested for Arch Linux yes_.
- **`zsh`**: The scripts assume `zsh` is the default shell.
- **`asdf`**: Used for managing versions of tools like `neovim`, `elixir`, and `erlang`.

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git
   cd dotfiles

   ```

2. Run the installation process using `make`:

```bash
make
```

This will:

- Execute the installation scripts (scripts/install_zsh.sh and install.sh).
- Create symbolic links for the dotfiles in your home directory.

To manually run the installation scripts:

```bash
make install
```

or

```bash
./scripts/install.sh
```

## Usage

### Linking Dotfiles

To create symbolic links for the dotfiles:

```bash
make link
```

### Deleting Links

To remove symbolic links created by `stow`:

```bash
make delete
```

### Customizing Configurations

_Neovim_: The install.sh script installs and optionally configures Neovim using vim-plug.
_Git_: The script prompts for your Git name and email to configure .gitconfig.
_Zsh_: The install_zsh.sh script sets up zsh and related configurations.

### Structure

`scripts`: Contains installation and helper scripts.
`templates`: Includes template files for configurations like .gitconfig.
.config: Configuration files for applications (e.g., Neovim).
Makefile: Automates installation and linking processes.
Notes
The install.sh script includes optional steps for configuring tools like Neovim and Git.
Some tools (e.g., erlang) may require manual installation due to known issues.
