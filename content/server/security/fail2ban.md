---
title: Fail2Ban Reference
date: "2018-02-28"
publish: true
tags: ["server", "security"]
---

Restart fail2ban if settings are changed.

## Install fail2ban

1. Install fail2ban

```bash
sudo apt-get update
sudo apt-get install fail2ban
```

## Create and edit the default settings

1. Make a copy of the config file for local changes

```bash
awk '{ printf "# "; print; }' /etc/fail2ban/jail.conf | sudo tee /etc/fail2ban/jail.local
```

2. Edit the file and adjust the following settings if needed

```bash
sudo nano /etc/fail2ban/jail.conf
```

```bash
# The default section
[DEFAULT]

# Addresses fail2ban will ignore
# You can add more by separating with a space
ignoreip = 127.0.0.1/8

# Length a client is banned (in seconds) 
bantime = 600

# The number of times a client can fail (maxretry) in the time window (findtime)
findtime = 600
maxretry = 3

# To set up email alerts check the following settings
# destemail = destination email, sendername = sender of the email, mta = mail service that will send the email
destemail = root@localhost
sendername = Fail2Ban
mta = sendmail

# What fail to ban does when findtime / maxretry is triggered
action = $(action_)s
```

```bash
# To see how fail2ban filters files (this is for advanced users)
ls /etc/fail2ban/filter.d
```

## Configure Jail settings

```bash
# Enable fail2ban
[jail-to-enable]
enabled = true
```

## A sample setup

1. Install the required dependencies for monitoring and sending alerts for an nginx server

```bash
# Update and install required libraries
sudo apt-get update
sudo apt-get install nginx sendmail iptables-persistent
```

## Sources

- https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-ubuntu-14-04