---
title: CMDer Notes
date: "2018-02-28"
publish: true
---


# Cmder

## Setting a default directory

1. Open the `init.bat` file which is usually located in `C:\Program Files\cmder\vendor`

2. Search for `Set home path`

3. Add the following line above it, so it looks like the following

```bash
@cd /d "C:\Users\<USERNAME>\Documents\programming"

:: Set home path
if not defined HOME set "HOME=%USERPROFILE%"
```

## Enable the ssh-agent

1. Navigate to `C:\Program Files\cmder\config` and open `user-profile.cmd`

2. Uncomment the following line:

```bash
:: uncomment this to have the ssh agent load when cmder starts
call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd"
```

## Caveats

- Make sure you use double quotation marks when making git comments

## Sources

- See [this thread](https://github.com/cmderdev/cmder/issues/91) for additional path setup
- See [this thread](https://github.com/cmderdev/cmder/issues/193) for agent setup