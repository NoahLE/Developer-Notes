# Raspbian (Lite) setup on OSX

## Table of Contents

- [Raspbian (Lite) setup on OSX](#raspbian-lite-setup-on-osx)
  - [Table of Contents](#table-of-contents)
  - [Installing Raspbian](#installing-raspbian)
  - [Logging into the Raspberry Pi](#logging-into-the-raspberry-pi)
  - [Basic configuration](#basic-configuration)
  - [Basic device lockdown](#basic-device-lockdown)
    - [Raspberry Pi's Guide](#raspberry-pis-guide)
    - [Changing passwords](#changing-passwords)
    - [Creating a new account](#creating-a-new-account)
  - [SSH Setup](#ssh-setup)
    - [Creating a CRON job to keep SSH up to date](#creating-a-cron-job-to-keep-ssh-up-to-date)
  - [Creating and installing the SSH key](#creating-and-installing-the-ssh-key)
  - [Setting up a basic firewall](#setting-up-a-basic-firewall)
  - [Installing Docker](#installing-docker)

## Installing Raspbian

Download the newest copy of Raspbian Lite from the [Raspberry Pi website](https://www.raspberrypi.org/downloads/raspbian/).

After downloading, the file needs to be trasferred to a microSD card for installation.
I used [Etcher](https://www.balena.io/etcher/) to write the `.zip` file to the card.

**Create a file in the root directory of the `boot` folder with the name `ssh`. This will allow you to log into the Pi for the rest of the installation steps.**

## Logging into the Raspberry Pi

First you need to find the IP of your Raspberry Pi. I'd recommend logging into your modem / router and finding it there.

To avoid needing to do this every time, I'd recommend assigning it a static IP address in the `DHCP Reservation` settings.

Once you have the IP, open your terminal and run the following command `ssh pi@IP-ADDRESS`. The accept the certificate and enter `raspberry` as the password.

## Basic configuration

First, install the newest updates by running:

```bash
# Upgrade everything!
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
```

Then, open up the config tool by running `sudo raspi-config`.

I'd recommend changing these options:

1. Change the password for `pi` by running the `passwd` command (Optional if you delete this account)
2. Change the locale (Option 4 -> I1)
   1. Use spacebar to select and unselect options and enter to proceed
   2. I recommend using UTF-8
3. Change the timezone (Option 4 -> I2)

Read the notes section below and restart your pi by running `sudo shutdown now -r`.

**Notes**

If you change your hostname, you may need to add something like the following to `/etc/hosts`

```bash
# An error may look like
# sudo: unable to resolve host raspberrypi
127.0.0.1 yourhostname
```

If you get locale warnings, those can be fixed by running the following:

```bash
# The warning may look like:
# perl: warning: Setting locale failed.
# perl: warning: Please check that your locale settings:
#	LANGUAGE = (unset),
#	LC_ALL = (unset),
#	LC_CTYPE = "en_US.UTF-8",
#	LANG = "en_GB.UTF-8"
#   are supported and installed on your system.
sudo locale-gen en_US.UTF-8
```

## Basic device lockdown

### Raspberry Pi's Guide

I highly recommend reading [this guide](https://www.raspberrypi.org/documentation/configuration/security.md) on the Raspberry Pi website. A lot of steps in this section are summarized from there and may be out of date.

### Changing passwords

Since your device is extremely exposed right now, I'd recommend taking a couple security precautions (use at your own risk).

Then, change the password for the `pi` account by running `passwd`.

I'd also recommend changing the root password with `sudo passwd root`.

### Creating a new account

An optional, but nice step is creating your own account.

```bash
# Create the new account
sudo adduser alice

# Add the account to the sudo group
sudo adduser alice sudo

# Change user accounts
sudo su momentum

# Delete the `pi` account
# Make sure to SSH in as the new user
# You may have to `sudo kill -9 <user process>`
sudo deluser -remove-home -f pi
```

If you want to make sudo require a password, that's your call. A great discussion about this is in this [StackOverflow thread](https://security.stackexchange.com/questions/45712/how-secure-is-nopasswd-in-passwordless-sudo-mode).

## SSH Setup

### Creating a CRON job to keep SSH up to date

By checking for SSH updates every day, you'll lower your risk of having a vulnerability.

```bash
# Edit the CRON table
crontab -e

# Add the following line to update every day at midnight
0 0 * * * apt install openssh-server
```

## Creating and installing the SSH key

I found [this great thread](https://askubuntu.com/questions/46424/how-do-i-add-ssh-keys-to-authorized-keys-file) explaining how SSH keys are used.

To create the SSH key run `ssh-keygen -t rsa`.

I'd recommend setting a unique name when creating the key: `Enter file in which to save the key (/Users/username/.ssh/id_rsa): /Users/username/.ssh/raspberry-pi-name`

Add the SSH key to your machine using `ssh-add ~/.ssh/key-name` (not the with that ends with `.pub`)

Copy the `.pub` version of the key over to the server. You may need to create a `.ssh` folder and `authorized_keys` file.

Alternatively, you can use the following command `ssh-copy-id -i ~/.ssh/THE-KEY USER@HOST`

You can test the new key with the following command:
`ssh -i ~/.ssh/THE-KEY USER@HOST`

```bash
# Create the ssh folder if needed
mkdir ~/.ssh

# Create the authorized_keys file if needed
touch ~/.ssh/authorized_keys

# Add the key to the file
sudo vi ~/.ssh/authorized_keys

# Paste the key and save

# Change the permission of the authorized_keys file so it can be read by ssh
sudo chmod 644 ~/.ssh/authorized_keys

# Disable password logins by editing the sshd_config file
sudo vi /etc/ssh/sshd_config

# Change these settings
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
PermitRootLogin no
AllowUsers USER

# Reload the ssh client
# OPEN A NEW CONNECTION TO TRY THIS JUST IN CASE SO YOU ARE NOT LOCKED OUT!
sudo service ssh reload
```

## Setting up a basic firewall

Install the `uncomplicated firewall` software by running `sudo apt install ufw`.

So we don't get kicked off, enable `ssh` connections by running `sudo ufw allow ssh`.

Start up the firewall with `sudo ufw enable`.

You can check its status at any time using the command `sudo ufw status` or `sudo ufw status verbose`.

Next up is install fail2ban. You can use the default settings for a good baseline. This software helps prevent brute force attacks against your pi.

```bash
# Install fail to ban
sudo apt install fail2ban

# Make a local file to save any changes you make
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

Done!

## Installing Docker

Installation is pretty simple.

```bash
# Install Docker
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh

# Add your user account to the docker group
sudo usermod -aG docker $USER

# Install pip so you can install docker-compose
sudo apt-get -y install python-pip

# Install docker-compose
sudo pip install docker-compose
```
