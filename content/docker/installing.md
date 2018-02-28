---
title: Docker Installation
date: "2018-02-28"
publish: true
---


# Docker

## Installing Docker

1. Install docker-ce (community edition)

```bash
# Install the GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to the APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Upgrade the package database because of the newly added repo
sudo apt-get update

# Make sure you are about to install the Docker version of the repo and not Ubuntu's version
apt-cache policy docker-ce

# The output should look like the following (notice the docker.com domain)

# docker-ce:
#   Installed: (none)
#   Candidate: 17.03.1~ce-0~ubuntu-xenial
#   Version table:
#      17.03.1~ce-0~ubuntu-xenial 500
#         500 https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
#      17.03.0~ce-0~ubuntu-xenial 500
#         500 https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
```

2. Make sure docker installed correctly and is running

```bash
sudo systemctl status docker

# It should output something like the following

# ● docker.service - Docker Application Container Engine
#    Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
#    Active: active (running) since Sun 2017-02-08 09:53:52 D\EST; 1 weeks 3 days ago
#      Docs: https://docs.docker.com
#  Main PID: 749 (docker)
```

## Sources

- [Docker Documentation](https://docs.docker.com/)
- [Install and use Docker on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)