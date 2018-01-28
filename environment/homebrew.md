# Homebrew (OSX)

[Homebrew]() is an awesome package manager for OSX.

## Installation

1. Install Ruby (this example uses [RVM](http://rvm.io/))(Other ways of installing Ruby can be [found here](https://www.ruby-lang.org/en/downloads/))

```bash
# Add the gpg key
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

2. Install Homebrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Learning about packages

1. To learn more about a package, run the info command

```bash
brew info <PACKAGE_NAME>
```