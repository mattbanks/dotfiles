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

## sublime text 2 setup

To pull in Sublime Text 2 User preferences, run:

```sh
cd ~/.dotfiles/
sublime2/setup
```

## syntax highlighting

…is really important. even for these files.

Install [Dotfiles Syntax Highlighting](https://github.com/mattbanks/dotfiles-syntax-highlighting-st2) via [Sublime Text 2 Package Control](http://wbond.net/sublime_packages/package_control)

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you. Fork it, remove what you
don't use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `rake install`.

## bugs

I use this as my dotfiles, so I know it works on my machines. If you run into any issues,
feel free to [open an issue](https://github.com/mattbanks/dotfiles/issues) on this repository.

Use your judgment, though. It may make more sense to
[open an issue](https://github.com/holman/dotfiles/issues) on holman's repository, which will
surely receive more attention from the community than mine will. I'll be pulling upstream
changes every once in a while.

## history

This is a major rewrite to my old dotfiles. Your mileage may vary will upgrading - I deleted all my old files before I started.

## thanks

Based on some killer work by [Zach Holman](https://github.com/holman/dotfiles), [Paul Irish](https://github.com/paulirish/dotfiles), [Mathias Bynens](https://github.com/mathiasbynens/dotfiles), [Ben Alman](https://github.com/cowboy/dotfiles), [Nicolas Gallagher](https://github.com/necolas/dotfiles), and [Chris Lopresto](https://github.com/chrislopresto/dotfiles). These are all awesome developers and you should be following them.
