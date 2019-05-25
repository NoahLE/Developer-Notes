---
title: SSH Reference
date: "2018-02-28"
publish: true
tags: ["server"]
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

## Changing the SSH Port

This is a simple but effective thing to do to prevent automated attacks.

1. First, find the location of `the sshd_config` file and edit it.

```bash
# It usually lives at the following location
sudo vi /etc/ssh/sshd_config
# You can also search for it by running the following command
find / -name "sshd_config" 2>/dev/null
```

2. Find the line which says `Port 22` or `#Port 22` and change it to `Port NEW_PORT` (it should be between port 1024 and 65535).

3. Make sure to add the new port to your firewall! For example, `sudo ufw allow 1234/tcp`

4. Restart the `ssh` or `sshd` service. For Ubuntu use `sudo systemctl restart ssh`.

5. Verify the port is open with one of these commands:

```bash
ss -tulpn | grep 2222
netstat -tulpn | grep 2222
```

6. Log in using your new port! `ssh -p {port} user@server`

More info about changing the port can be [found here](https://www.cyberciti.biz/faq/howto-change-ssh-port-on-linux-or-unix-server/).

## Debugging SSH

Somethings that could wrong is the ssh-agent isn't running, the key isn't added to the agent, the key hasn't been added to the version control system and activated.

You can get a verbose log of the attempted connection by running:

```bash
# -1 means key is not found
# if you use a custom key, make sure to use a config file
ssh -vT git@github.com
```

## Sources

- [Generating a ssh key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
- [Installing SSH in Ubuntu](https://askubuntu.com/a/51926)
- [Hardening SSH](https://thepcspy.com/read/making-ssh-secure/)