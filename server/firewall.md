# Firewall (using UFW)

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