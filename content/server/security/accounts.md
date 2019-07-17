---
title: User account reference
date: "2018-02-28"
publish: true
tags: ["server", "security"]
---

## Access the root account if it does not have a password set

If you would like to access the `root` account and it does not have a password set, you can access it by either using the `su root` command or `sudo -i`. If you would like to set the password, run the command `sudo passwd root`.

## Changing password

- To change passwords use the `passwd` command

```bash
# You will be prompted to enter the current password and reenter the new password twice
sudo passwd <USERNAME>
```

## Creating a new user (with sudo access)

It's a good idea to create a sandbox user so you don't have to use the `root` account.

1. Create a new user with the `adduser NEW_USER` command

2. Add them to the sudo group with `usermod -aG sudo NEW_USER`

3. Switch to the new account so we can test if they have `sudo` access by running `su - NEW_USER`

4. Run something like `sudo apt-get update` to see if the proper permissions are set up

## Allow SSH for new user

1. After creating the new user account, create a `.ssh` folder for them using `mkdir /home/USER/.ssh`

2. Add an `authorized_keys` file to the `.ssh` folder with `touch /home/USER/.ssh/authorized_keys`

3. Make sure the new ssh folder and file is owned by the user with `chmod 700 /home/USER/.ssh/`

4. Copy the ssh public key into the authorized keys file so you can login and change the permissions of the file with `chmod 600 /home/USER/authorized_keys`

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
sudo service ssh restart
```

4. If you use an SSH key to login, make sure you have added it to the `authorized_keys` file.

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

4. If you use an SSH key to login, make sure you add it to the new user's `authorized_keys` file (this is usually in `~/.ssh/authorized_keys`)

## Sources

- [General SSH keys guid](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)
- [Changing user passwords](https://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/changing-user-passwords.html)
- [Disabling password authentication](htptps://askubuntu.com/a/435620)
- [PermitRootLogin explanation](https://askubuntu.com/questions/449364/what-does-without-password-mean-in-sshd-config-file#449372) or [PermitRootLogin setting](https://serverfault.com/a/178087)
- [Setting the root password](https://askubuntu.com/a/364316)
