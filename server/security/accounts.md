# Accounts

## Changing password

- To change passwords use the `passwd` command

```bash
# You will be prompted to enter the current password and reenter the new password twice
sudo passwd <USERNAME>
```

## Disable the password for Root login

```bash
sudo nano /etc/ssh/sshd_config
```

```bash
# Add the following to the file
PermitRootLogin without-password
```

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