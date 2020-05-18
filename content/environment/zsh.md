---
title: ZSH Reference (shell replacement)
date: "2018-02-28"
publish: true
tags: ["environment", "shell"]
---

My `.zshrc` file. See the [bashrc](environemt/bashrc) page for more terminal settings.

## Installation of oh-my-zsh

1. From the terminal run this command

```bash
# Using curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Using wget
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

```

## Other tools for oh-my-zsh

- [Antigen](https://github.com/zsh-users/antigen) is a great tool for managing plugins

## ZSH Configuration

These are some ZSH settings I've found to be helpful.
See the [bashrc](environment/bashrc) page for more useful settings.

```bash
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/home/jinx/.oh-my-zsh"
export UPDATE_ZSH_DAYS=7

ZSH_THEME="agnoster"
ENABLE_CORRECTION="true"
# DISABLE_MAGIC_FUNCTIONS=true
# COMPLETION_WAITING_DOTS="true"

plugins=(git)

# Aliases
alias ls="ls -la"
alias ohmyzsh="code ~/.oh-my-zsh"
alias ua="sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y"
alias updatethefuck="pip3 install thefuck --upgrade"

# The fuck
eval $(thefuck --alias)

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Load that shit
source $ZSH/oh-my-zsh.sh
```

## Caveats

If there's a lot of broken icons, you may need to install a powerline font. I recommend using the `Meslo LG M DZ Regular for Powerline` from [this repo](https://github.com/powerline/fonts).
