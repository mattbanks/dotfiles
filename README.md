# Matt's dotfiles...

Based on dotfiles by [Paul Irish](https://github.com/paulirish/dotfiles), [Mathias Bynens](https://github.com/mathiasbynens/dotfiles), [Ben Alman](https://github.com/cowboy/dotfiles), and [Nicolas Gallagher](https://github.com/necolas/dotfiles)

## Installation

### Using Git and the bootstrap script

```bash
git clone https://github.com/mattbanks/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
./bootstrap.sh -f
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

### Sensible Homebrew defaults

This script installs [Homebrew](http://mxcl.github.com/homebrew/) so you don't have to before-hand, then run the following to install core packages:

```bash
./.brew
```

### Package Management setup

Make sure `./.brew` is installed before running this script ([Node.js](http://nodejs.org/) needs to be installed first). This installs [NPM](http://npmjs.org/) and [RVM](https://rvm.io/) and various web development packages.

```bash
./.packages
```

## Suggestions/Improvements

Suggestions/improvements welcome - [let me know](https://github.com/mattbanks/dotfiles/issues)!