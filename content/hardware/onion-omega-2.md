---
title: Onion Omega 2 Notes
date: "2018-02-28"
publish: true
tags: ["hardware", "onion-omega-2"]
---

## Console not showing up when connecting to the device

Sometimes when you do a hard reset, the console does not show up when logging into the device. To fix this, you need to reinstall the onion console and reboot the device.

```bash
# Update the package manager
opkg update

# Install the onion console
opkg install onion-console-base

# Reboot the device
etc/init.d/rpcd restart
```

## Sources

-[First time setup](https://docs.onion.io/omega2-docs/first-time-setup.html)
- [Installing the console](https://community.onion.io/topic/1416/resolved-restoring-after-a-factory-reset)