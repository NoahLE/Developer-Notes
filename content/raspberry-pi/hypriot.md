# Hypriot setup on OSX

## Table of Contents

- [Hypriot setup on OSX](#hypriot-setup-on-osx)
  - [Table of Contents](#table-of-contents)
  - [Installing Hypriot](#installing-hypriot)
  - [Logging into the device](#logging-into-the-device)
  - [Creating a new user account](#creating-a-new-user-account)
  - [Installing an SSH key](#installing-an-ssh-key)
  - [Hardening logins](#hardening-logins)
  - [Installing PiVPN](#installing-pivpn)
  - [Modem / router configuration](#modem--router-configuration)

## Installing Hypriot

First, flash Hypriot onto your microSD card.

```bash
# Install `flash` (from Hypriot)
# Newest version listed here: https://github.com/hypriot/flash/releases
# The hostname is what the device will show up as on the network
curl -LO https://github.com/hypriot/flash/releases/download/2.2.0/flash

# Allow it to be executed
chmod +x flash

# Copy it to the bin folder for command line execution
sudo mv flash /usr/local/bin/flash

# Download the Hypriot image
# Newest version listed here: https://blog.hypriot.com/downloads/
flash --hostname DEVICE_NAME https://github.com/hypriot/image-builder-rpi/releases/download/v1.9.0/hypriotos-rpi-v1.9.0.img.zip

# Make sure your microSD card is plugged in

# When prompted, eject the microSD card and put it into your Raspberry Pi
```

## Logging into the device

As an optional, but useful step, assign your Raspberry Pi a static IP address.
To do this, go to your router and under the DHCP reservation page (name may vary), and assign it a static IP address.

Now, it's time to login and install some updates. Plug in the power cord and an ethernet cable.

```bash
# Log into the device
# You can find the device's IP under your router / modem's connected devices page
ssh pirate@DEVICE_IP

# The default password is `hypriot`

# Update everything
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
```

## Creating a new user account

```bash
# Change the default password
passwd
<Enter new password when prompted>

# Make a new user
sudo /usr/sbin/useradd --groups sudo -m ACCOUNT_NAME

# Set the password for your new account
sudo passwd ACCOUNT_NAME
<Enter a new passwork when prompted>

# Set a new password for the `root` account
sudo passwd root
<Enter a new passwork when prompted>

# ERROR: .bash_prompt -> Syntax error: "(" unexpected
# Disable the `pirate` account
sudo passwd --lock pirate
```

## Installing an SSH key

On a local machine, generate the key. Then, add it to the server.

```bash
# Generate the key
ssh-keygen -t rsa

# Add it to the server
# Note: The location of the key may vary
ssh-copy-id -i $HOME/.ssh/NAME-OF-KEY.pub USERNAME@SERVER-ADDRESS

# Add the key
ssh-add ~/.ssh/NAME-OF-KEY
```

## Hardening logins

Disable the root login and password based logins

```bash
# Edit the sshd_config and change the following settings:
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
PermitRootLogin no

# Reload the ssh server
sudo systemctl reload ssh
```

## Installing PiVPN

Install PiVPN

```bash
# Log into your Raspberry Pi, make sure it's connected to the internet, and run the following command
curl -L https://install.pivpn.io | bash

# Create a new profile by running
pivpn add

# Copy the .ovpn file off the server
scp USERNAME@SERVER-ADDRESS:/home/USERNAME/ovpns/OVPN-NAME.ovpn ~/Downloads
```

## Modem / router configuration

These settings are highly specific to your current network setup. These are the results that worked for me.

```bash
# After assigning a static IP address, go to your router or modem's settings and enable port forwarding.
# I set my PiVPN to use a custom port, so the rule was the following:
Local lan port: - My PiVPN port
Local lan IP address: The static IP of my Raspberry Pi
Protocol: I chose UDP
WAN Ports: My PiVPN port to the same port
Remote IP Address: This should either be the IP addresses of all devices connecting or all IPs (the former being more secure)
```