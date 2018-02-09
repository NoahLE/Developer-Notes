# rsync

## Installing rsync

Always use rsync over SSH.

## Common flags

- -r = recurse directories
- -a = archive mode
- -v = verbose
- -e = ssh options
- -z = compress data files

```bash
# Copy file from local computer to remote server
# Example rsync -ve ssh ~/file.tar user@server.com:~
rsync -v -e <FILE> <SSH_USERNAME>@<SERVER_INFO>:<FILE LOCATION>

# Copy file from remote server to local computer
# Example: rsync -ve ssh user@server.com:~/file.txt /tmp
rsync -v -e ssh <SSH_USERNAME>@<SERVER_INFO>:<FILE_LOCATION> <LOCAL_LOCATION>