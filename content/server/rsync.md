---
title: rsync Reference
date: "2018-02-28"
publish: true
---

## Installing rsync

Always use rsync over SSH.

## Common flags

- -r = recurse directories
- -a = archive mode
- -v = verbose
- -e = ssh options
- -z = compress data files


### Copy file from local computer to remote server

```bash
# Example rsync -ve ssh ~/file.tar user@server.com:~
rsync -v -e <FILE> <SSH_USERNAME>@<SERVER_INFO>:<FILE LOCATION>
```
### Copy file from remote server to local computer

```bash
# Example: rsync -ve ssh user@server.com:~/file.txt /tmp
rsync -v -e ssh <SSH_USERNAME>@<SERVER_INFO>:<FILE_LOCATION> <LOCAL_LOCATION>
```

## Sources

- [How to use rsync](https://www.cyberciti.biz/tips/linux-use-rsync-transfer-mirror-files-directories.html)