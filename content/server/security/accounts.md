---
title: User account reference
date: "2018-02-28"
publish: true
---


# Accounts

## Access the root account if it does not have a password set

If you would like to access the `root` account and it does not have a password set, you can access it by either using the `su root` command or `sudo -i`. If you would like to set the password, run the command `sudo passwd root`.

## Changing password

- To change passwords use the `passwd` command

```bash
# You will be prompted to enter the current password and reenter the new password twice
sudo passwd <USERNAME>
```

## Disable Root login

1. Open `/etc/ssh/sshd_config` with your favorite text editor

```bash
sudo vi /etc/ssh/sshd_config
```

2. Change the following line:

```bash
# Add or edit the following to the file
PermitRootLogin no
# Alternatively, if you would like to allow root login, but not with a password set it to:
# PermitRootLogin without-password
```

3. Restart the service

```bash
# Restart the service
sudo systemctl reload sshd.service
```

## Disable password authentication

1. Open `/etc/ssh/sshd_config` in your favorite text editor

```bash
sudo vi /etc/ssh/sshd_config
```

2. Change the `PasswordAuthentication` line to no

```bash
# It will most likely be:
# #PasswordAuthentication yes
# It should be changed to the following:
PasswordAuthentication no
```

3. Restart the SSH service

```bash
sudo service ssh restart
```

## Sources

- [Changing user passwords](https://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/changing-user-passwords.html)
- [Disabling password authentication](htptps://askubuntu.com/a/435620)
- [PermitRootLogin explaination](https://askubuntu.com/questions/449364/what-does-without-password-mean-in-sshd-config-file#449372) or [PermitRootLogin setting](https://serverfault.com/a/178087)
- [Setting the root password](https://askubuntu.com/a/364316)