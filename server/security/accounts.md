# Accounts

# Disable the password for Root login

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