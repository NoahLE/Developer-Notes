---
title: NPM Notes
date: "2019-06-23"
publish: true
tags: ["server"]
---

## Ansible Setup on Control Machine

1. Install Ansible

```bash
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

2. If it does not exist, create a `hosts` file in `/etc/ansible/hosts` with `mkdir -p /etc/ansible/hosts`. NOTE: Make sure your public SSH key is in the `authorized_keys` file on the host system.

3. Added the system to the machine so it looks something like this:

```bash
192.0.2.50
aserver.example.org
bserver.example.org
```

3. Test that ansible can access the machines with `ansible all -m ping`

4. If you need to change users, you can run the following command:

```bash
# as bruce
$ ansible all -m ping -u bruce
# as bruce, sudoing to root (sudo is default method)
$ ansible all -m ping -u bruce --become
# as bruce, sudoing to batman
$ ansible all -m ping -u bruce --become --become-user batman
```

5. Test running a live command `ansible all -a "/bin/echo hello"`
