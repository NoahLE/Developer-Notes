
# .bashrc File Configuration

I use the ZSH shell which uses a .zshrc file instead of .bashrc to store settings. 
A lot of these commands should be usable in whatever shell you use.

## General Configuration

These are some general bash settings I found helpful.

```bash
# Changing and adding folders to the system path
# After changing this the shell should be reloaded
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:<CUSTOM_PATH>:/Users/<USER>/programming"
export EDITOR="code"

# Custom shortcuts
# The format is: alias <NAME>='<COMMAND>'
alias ls='ls -l'
alias cdp='cd ~/programming; clear; ls;'

# Custom git shortcuts
alias gitp='git add -p'
alias gitl='git log --oneline --decorate --all --graph'
alias gitds='git diff --staged'

# Other programming aliases
alias ua='brew update && brew upgrade && brew cleanup && antigen update'
alias pm='python manage.py'
alias djangocookie='cookiecutter https://github.com/pydanny/cookiecutter-django'

# System utility commands
alias reload='. ~/.zshrc'
alias antigenfix='rm ~/.antigen/init.zsh'

# Virtualenvwrapper settings
source /usr/local/bin/virtualenvwrapper.sh

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/Cellar/python3/3.6.4_2/bin/python3
# export VIRTUALENVWRAPPER_VIRTUALENV=/Users/crux/.virtualenvs
# export PROJECT_HOME=$HOME/programming

# Directory settings
umask 022
```


## ZSH Configuration

These are some ZSH settings I've found to be helpful.

```bash
# Path to oh-my-zsh
export ZSH=/Users/crux/.oh-my-zsh

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Command auto-correction
ENABLE_CORRECTION="true"

# User configuration
source /usr/local/share/antigen/antigen.zsh

# Set up antigen
antigen use oh-my-zsh

# Bundle install
antigen bundle git
antigen bundle git-extras
antigen bundle pip
antigen bundle brew
antigen bundle python
antigen bundle zlsun/solarized-man
antigen bundle command-not-found
antigen bundle pylint

# Load a theme
antigen theme KuoE0/oh-my-zsh-solarized-powerline-theme solarized-powerline

# Tell antigen you're done
antigen apply

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```