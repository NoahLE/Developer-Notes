---
title: SSH Reference
date: "2018-02-28"
publish: true
---

## Installing SSH and allowing it through the firewall

1. First update your repositories

```bash
sudo apt update
```

2. Install SSH

```bash
sudo apt install ssh
```

3. Allow SSH through the `ufw` firewall

```bash
# Note: you change this rule if you have changed your SSH port
sudo ufw allow 22
```

## Creating a key

1. Create the key on a client machine:

```bash
# t = type of encryption, b = bits, C = comment
ssh-keygen -t rsa -b 4096 -C "a comment here"
```

```bash
Enter file in which to save the key (/Users/crux/.ssh/id_rsa): ~/.ssh/<KEY-NAME>
Enter passphrase (empty for no passphrase): <PASSWORD>
Enter same passphrase again: <PASSWORD>
```

## Adding the SSH key to the ssh-agent

1. Start the ssh-agent

```bash
eval "$(ssh-agent -s)"
```

```bash
# If using OSX, add the following to ~/.ssh/config to autoload the agent and store your password in the keychain
Host *
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile ~/.ssh/<KEY_NAME>
```

2. Add the SSH key

```bash
ssh-add ~/.ssh/<KEY_NAME>
```

## Sending the key to the server

1. Send the key to the server under the `authorized_keys` file

```bash
cat ~/.ssh/<SSH-KEY>.pub | ssh <USERNAME>@<SERVER_IP> "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
```

2. Accept the prompt

```bash
The authenticity of host '<SERVER_IP> (<SERVER_IP>)' can't be established.
RSA key fingerprint is <rsa-fingerprint>.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '<SERVER_IP>' (RSA) to the list of known hosts.
<USER>@<SERVER_IP>'s password: <PASSWORD> 
```

## Sources

- [Generating a ssh key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
- [Installing SSH in Ubuntu](https://askubuntu.com/a/51926)
- [Hardening SSH](https://thepcspy.com/read/making-ssh-secure/)