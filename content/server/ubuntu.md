---
title: Ubuntu reference
date: "2018-02-28"
publish: true
tags: ["operating systems", "security"]
---

## Chaining commands

You can chain commands together by using `&&`. For example: `sudo apt-get update && apt-get upgrade && apt-get dist-upgrade`.

## Useful commands

- Fetch list of available packages

```bash
sudo apt-get update
```

- Upgrade the currently installed packages

```bash
sudo apt-get upgrade
```

- Install all updates

```bash
sudo apt-get dist-upgrade
```

- Get network info

```bash
ifconfig
```