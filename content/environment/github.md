---
title: Github Reference
date: "2018-02-28"
publish: true
---


# Creating and adding an SSH key to Github

1. If you would like to use an existing key, check the .ssh directory (skip step 2 if this is the case)

```bash
ls -al ~/.ssh
```

2. Generate a new ssh key

```bash
# -t = type, -b = bits, -C = comment
ssh-keygen -t rsa -b 4096 -C "your_email@email.com"
```

It should produce a prompt that looks like the following:

```bash
# The prompt should look something like this:
$ ssh-keygen -p
Enter file in which the key is (/Users/you/.ssh/id_rsa): <PRESS_ENTER> or <FILE_LOCATION>/<FILE_NAME>
Key has comment '/Users/you/.ssh/id_rsa'
Enter new passphrase (empty for no passphrase): <SSH_PASSWORD>
Enter same passphrase again: <SSH_PASSWORD>
Your identification has been saved in <FILE_LOCATION>
Your public key has been saved in <FILE_LOCATIONS>
```

3. If using Windows, set up auto-launching for the SSH-Agent

```bash
# If you are using Windows, add the following script to your ~/.bashrc, ~/.profile, or other terminal settings file
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
```

## Sources

- [Connecting to Github](https://help.github.com/articles/connecting-to-github-with-ssh/)