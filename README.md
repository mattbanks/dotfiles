# matt's dotfiles

> Config files for ZSH, Node, Ruby, Go, Editors, Terminals and more.

## Installation

### Dependencies

First, make sure you have all those things installed:

- `git`: to clone the repo
- `curl`: to download some stuff
- `tar`: to extract downloaded stuff
- `zsh`: to actually run the dotfiles
- `sudo`: some configs may need that
- `brew`: setup scripts assume this is installed

Change your shell to zsh:

`chsh -s /bin/zsh`

In Mojave, you need to enable Full Disk Access for iTerm and Terminal:

> Settings.app -> "Security & Privacy" -> "Full Disk Access"

### Install

Then, run these steps:

```console
$ git clone https://github.com/mattbanks/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./script/bootstrap
$ zsh # or just close and open your terminal again.
```

> All changed files will be backed up with a `.backup` suffix.

This will symlink the appropriate files in `.dotfiles` to your home directory.

### Recommended Software

For both Linux and macOS:

- `diff-so-fancy`: better git difs (you'll need to run `dot_update` to apply it);
- `exa`: for better `ls`.

### macOS defaults

You use it by running:

```sh
$DOTFILES/macos/set-defaults.sh
```

And logging out and in again.

### new machine setup

To setup a new machine with brew, node, ruby and run all installers in this repo, run:

```sh
$DOTFILES/script/setup_machine
```

## contributing

Feel free to contribute :)

## thanks

This is largely based off [Zach Holman's dotfiles](https://github.com/holman/dotfiles) and [Carlos Becker's dotfiles](https://github.com/caarlos0/dotfiles). They're both awesome and you should definitely check out they're great code on Github!
