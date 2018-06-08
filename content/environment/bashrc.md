---
title: .bashrc Configuration
date: "2018-02-28"
publish: true
tags: ["environment", "shell"]
---

I use the ZSH shell which uses a .zshrc file instead of .bashrc to store settings. 
A lot of these commands should be usable in whatever shell you use.

See the [zshrc](enviroment/zshrc) page for more settings.

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
alias ua='brew update && brew upgrade && brew cleanup && antigen update && npm update -g'
alias pm='python manage.py'
alias djangocookie='cookiecutter https://github.com/pydanny/cookiecutter-django'

# System utility commands
alias reload='. ~/.zshrc'
alias antigenfix='rm ~/.antigen/init.zsh'

# General utility functions

# Creates a folder and cds into it
function mcd() {
  mkdir -p $1;
  cd $1;
}

# Extracts a file based on the file extension
function extract() {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# Change username
export DEFAULT_USER=`whoami`

# Virtualenvwrapper settings
source /usr/local/bin/virtualenvwrapper.sh

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/Cellar/python3/3.6.4_2/bin/python3
# export VIRTUALENVWRAPPER_VIRTUALENV=/Users/crux/.virtualenvs
# export PROJECT_HOME=$HOME/programming

# Directory settings
umask 022
```
