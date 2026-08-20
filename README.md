# matt's dotfiles

> Config files for ZSH, development runtimes, editors, terminals, and more.

## Installation

### Dependencies

First, make sure you have macOS developer tools installed:

> `xcode-select --install`

The bootstrap script installs Homebrew when needed, installs the public `Brewfile`, and then runs each topic installer.

### Install

Clone the repo to `~/.dotfiles`, then run the bootstrap script:

```console
$ git clone https://github.com/mattbanks/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./script/bootstrap
$ zsh # or just close and open your terminal again.
```

> All changed files will be backed up with a `.backup` suffix.

This will symlink the appropriate files in `.dotfiles` to your home directory.

## Runtime management

[mise](https://mise.jdx.dev/) manages Node, Python, and Ruby. The public defaults live in `mise/config.toml` and are linked into mise's global `conf.d` directory, leaving `~/.config/mise/config.toml` available for machine-local overrides.

The global defaults track Node LTS and the latest stable Python and Ruby releases after a seven-day release-age buffer. Projects should pin the version they require in `mise.toml` or an idiomatic version file such as `.nvmrc`,
`.python-version`, or `.ruby-version`.

Python and Ruby use precompiled binaries so a clean setup does not need a local runtime build toolchain.

`uv` remains the Python project and virtual-environment manager. Global Node CLI tools are installed through mise so they are not tied to a particular Node installation. Both npm and pnpm are available; projects can select pnpm through their `packageManager` declaration.

### Recommended Software

Installed from the `Brewfile` during bootstrap:

- `awscli`: AWS command line interface.
- `eza`: for better `ls`.
- `gh`: GitHub CLI.
- `git`: newer than the version macOS ships.
- `mise`: runtime and global CLI tool manager.
- `starship`: the shell prompt.
- `uv`: Python packaging and virtual environments.

Installed separately:

- [Ghostty](https://ghostty.org): the terminal emulator. `ghostty/install.sh` links `ghostty/config` to `~/.config/ghostty/config`, so the font, theme, and window settings travel with the repo.

### macOS defaults

You use it by running:

```sh
$DOTFILES/macos/set-defaults.sh
```

And logging out and in again.

### New machine setup

After bootstrapping the dotfiles, the optional machine setup script creates an SSH key when needed and applies the macOS defaults:

```sh
$DOTFILES/script/setup_machine
```

## contributing

Feel free to contribute :)

## thanks

This is largely based off [Zach Holman's dotfiles](https://github.com/holman/dotfiles) and [Carlos Becker's dotfiles](https://github.com/caarlos0/dotfiles). They're both awesome and you should definitely check out they're great code on Github!
