---
title: ZSH Reference (shell replacement)
date: "2018-02-28"
publish: true
tags: ["environment", "shell"]
---

My `.zshrc` file. See the [bashrc](environemt/bashrc) page for more terminal settings.

## Installation

1. From the terminal run this command

```bash
# Using curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Using wget
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

```

## Other tools

- [Antigen](https://github.com/zsh-users/antigen) is a great tool for managing plugins
- [Solarized Powerline Theme](https://github.com/kuoe0/oh-my-zsh-solarized-powerline-theme) - A great looking theme for zsh

## ZSH Configuration

These are some ZSH settings I've found to be helpful.
See the [bashrc](environment/bashrc) page for more useful settings.

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

## Caveats

If there's a lot of broken icons, you may need to install a powerline font. I recommend using the `Meslo LG M DZ Regular for Powerline` from [this repo](https://github.com/powerline/fonts).