# Matt's dotfiles...

Based on dotfiles by [Paul Irish](https://github.com/paulirish/dotfiles), [Mathias Bynens](https://github.com/mathiasbynens/dotfiles), [Ben Alman](https://github.com/cowboy/dotfiles), and [Nicolas Gallagher](https://github.com/necolas/dotfiles)

## Installation

### Using Git and the bootstrap script

```bash
git clone https://github.com/mattbanks/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

### Git-free install

```bash
cd; curl -#L https://github.com/mattbanks/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```

To update later on, just run that command again.

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

## upstream

Suggestions/improvements
[let me know](https://github.com/mattbanks/dotfiles/issues)!
