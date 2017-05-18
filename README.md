# matt's dotfiles...

This is my dotfiles repo. There are many like it, but this one is mine.

A large portion of this README comes straight from [Zach Holman's dotfiles](https://github.com/holman/dotfiles).

## prerequisites

Install [Homebrew](https://github.com/mxcl/homebrew) before running the bootstrap installation script. Having [Git](http://git-scm.com) might not hurt either.

Set your shell to ZSH, because it's better than Bash (at least I think so).

`chsh -s /bin/zsh`

Better yet, run the killer [laptop script](https://github.com/mattbanks/laptop) to get your machine all setup with Homebrew, Node.js, Git, and some other important development tools.

## install

Run this:

```sh
git clone https://github.com/mattbanks/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

You'll also want to change `git/gitconfig.symlink`, which will set you up as
committing as me. You probably don't want that.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## new machine setup

To setup a new machine with brew, node, ruby and run setup for Atom, Sublime
Text 3, Atom, Xcode, etc, run:

```sh
cd ~/.dotfiles/
script/setup_machine
```

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/mattbanks/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](http://caskroom.io) to install: things like Chrome and 1Password and Adium and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as *my* dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/mattbanks/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## history

This is a major rewrite to my old dotfiles. Your mileage may vary will upgrading - I deleted all my old files before I started.

## thanks

Based on some killer work by [Zach Holman](https://github.com/holman/dotfiles), [Paul Irish](https://github.com/paulirish/dotfiles), [Mathias Bynens](https://github.com/mathiasbynens/dotfiles), [Ben Alman](https://github.com/cowboy/dotfiles), [Nicolas Gallagher](https://github.com/necolas/dotfiles), and [Chris Lopresto](https://github.com/chrislopresto/dotfiles). These are all awesome developers and you should be following them.
