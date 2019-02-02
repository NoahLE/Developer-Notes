# Installing Pi-VPN and Pi-Hole

The [PiVPN](http://www.pivpn.io) install is very simple.

The official Pi-Hole installation guide [is located here](https://docs.pi-hole.net/guides/vpn/overview/).

- [Installing Pi-VPN and Pi-Hole](#installing-pi-vpn-and-pi-hole)
  - [Prerequisites](#prerequisites)
  - [Pi-VPN Installation](#pi-vpn-installation)

## Prerequisites

1. Finish installing an operating system on your Raspberry Pi like Raspbian or Hypriot
2. Give your Raspberry Pi a static IP address
3. While in your modem, set up port forwarding for port 1194.
4. Install some kind of OpenVPN software like [TunnelBlick](https://tunnelblick.net/)

## Pi-VPN Installation

1. Log into your Raspberry Pi and run `curl -L https://install.pivpn.io | bash`
2. Most of the default settings will be fine (choose whatever level of encryption you would like, UDP, port 1194, Google DNS for now, allow auto-updates, etc)
3. Once the installation is complete, restart your Pi
4. Add a new profile by running `pivpn add`
5. Copy the profile to the device which will be using the VPN
   1. On Linux / Mac the command will be something like `scp PI-USERNAME@PI-ADDRESS:/home/USERNAME/ovpns/PROFILE-NAME.ovpn ~/Downloads`
   2. Double click the file to install it to your OpenVPN client
6. Add the certificate to your VPN of choice (I use `tunnelblick`)
7. Test the connection!