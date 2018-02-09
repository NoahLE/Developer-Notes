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

## Sources 

- [Changing user passwords](https://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/changing-user-passwords.html)