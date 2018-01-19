# SSH Keys

1. Create the key on a client machine:

```
ssh-keygen -t rsa
```

```
Enter file in which to save the key (/Users/crux/.ssh/id_rsa): ~/.ssh/<KEY-NAME>
Enter passphrase (empty for no passphrase): <password>
Enter same passphrase again: <password>
```

2. Send the key to the server under the `authorized_keys` file

```
cat ~/.ssh/<SSH-KEY>.pub | ssh <USERNAME>@<SERVER_IP> "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
```

3. Accept the prompt

```
The authenticity of host '<SERVER_IP> (<SERVER_IP>)' can't be established.
RSA key fingerprint is <rsa-fingerprint>.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '<SERVER_IP>' (RSA) to the list of known hosts.
<USER>@<SERVER_IP>'s password: <PASSWORD> 
```

4. Disable the password for Root login

```
sudo nano /etc/ssh/sshd_config
```

```
# Add the following to the file
PermitRootLogin without-password
```

```
# Restart the service
sudo systemctl reload sshd.service
```

## Sources

- 