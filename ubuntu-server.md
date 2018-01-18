# Ubuntu Server Setup

These are notes for setting up and running Django on a Ubuntu 16.04 web server

## Security

The following sections exist:

- SSH Keys
- Firewall (using UFW)

### SSH Keys

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
cat ~/.ssh/<SSH-KEY>.pub | ssh <USERNAME>@<SERVER-IP> "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
```

3. Accept the prompt

```
The authenticity of host '<SERVER-IP> (<SERVER-IP>)' can't be established.
RSA key fingerprint is <rsa-fingerprint>.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '<SERVER-IP>' (RSA) to the list of known hosts.
<USER>@<SERVER-IP>'s password: <PASSWORD> 
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

### Firewall (using UFW)

- Stands for Uncomplicated Firewall
- It's a front-end to iptables

1. Install UFW

```
sudo apt-get install ufw
```

2. Allow IPv6

```
sudo vi /etc/default/ufw
```

```
# Add the following line
IPV6=yes
```

3. Deny all incoming and allow all outgoing

```
sudo ufw default deny incoming
sudo ufw defauly allow incoming
```

4. Add or delete rules for needed ports

```
# Add rules

# format is: sudo ufw <ALLOW/DENY> <PORT>/<PROTOCOL>
sudo ufw allow ssh
sudo ufw allow www
sudo ufw allow 21/tcp
sudo ufw allow 80/tcp
sudo ufw allow ftp

# for an ip range: sudo ufw <ALLOW/DENY> <PORT>:<PORT>/<PROTOCOL>
sudo ufw allow 1000:2000/udp

# for a specific IP
sudo ufw allow from <IP>
```

```
# Delete rules
sudo ufw delete <ALLOW/DENY> <RULE>

sudo ufw status numbered
sudo ufw delete <NUMBER>
```

5. Enable, disable, or reset the firewall

```
sudo ufw enable
sudo ufw disable
sudo ufw reset
```

5. Check the status of UFW

```
sudo ufw status
sudo ufw status verbose
```