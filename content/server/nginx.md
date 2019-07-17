# nginx

nginx uses one master process which handles configuration and the worker processes. The worker processes handle the actual requests.

## Sending commands to nginx

Commands are sent via `nginx -s <signal>`. When the command is sent, the worker processes finish serving their current requests before executing the signal.

The possible signals are the following:

- `nginx -g daemon off;` - standard nginx run command
- `stop` — fast shutdown
- `quit` — graceful shutdown
- `reload` — reloading the configuration file
- `reopen` — reopening the log files

## Configuration

By default the configuation file is named `nginx.conf` and is stored either in `user/local/nginx/conf`, `/etc/nginx`, or `/usr/local/etc/nginx`.

When a new configuration is loaded, the master process tries to apply it. If it is a success, new processes are spun up and the old processes are sent a command to quit (they will serve all of their current requests before shutting down). If the config fails, the master process rolls back to the old config (worker processes may still shut down after finishing servicing their requests).

The kill command can be used to terminate worker processes. `ps -ax | grep nginx` will list the threads and `kill -s QUIT ####` will kill the process.

### Configuation Layout

The config file is made from simple or block directives. The main context is the upper-most block.

### Example configuration file

This is an example for a server which serves static content. The root folder is `/data`. Inside of data is a `www/` folder which holds the html and `images/` which holds the images.

```nginx
http {
    server {
        <!-- If multiple location blocks are found, the longest prefix will be chosen -->
        location / {
            root /data/www;
        }

        location /images/ {
            root /data;
        }
    }
}
```

### Example Proxy Server

This example builds on the `Example Configuration File` code.

The server the requests are proxied to listens on `8080` and maps all requests to `data/up1/`.

```nginx
<!-- This is the proxied server -->
server {
    listen 8080;
    root /data/up1;

    <!-- location / {
        <!-- Routing stuff here -->
    } -->

    location ~ \.(gif|jpg|png)$ {
        root /data/images;
    }
}

server {
    location / {
        proxy_pass http://localhost:8080;
    }

    location /images/ {
        root /data;
    }
}
```

## Logs

If something goes wrong, you can check `access.log` in `/usr/local/nginx/logs` or `/var/log/nginx`.

## Password Protecting Pages

1. Install the required dependencies with `sudo apt install apache2-utils`

2. Create a password file with `htpasswd -c /etc/nginx/.PASSWORD-FILE-NAME` (the standard is `.htpasswd`)

3. Create any additional users by running the same command without `-c`

4. If you haven't already, create a config file in `etc/nginx/sites-available/SITE-NAME`

5. Add the following lines to the file

```bash
location /PASSWORDED-URL {
    auth_basic              "Basic Auth";
    auth_basic_user_file    "/etc/nginx/.PASSWORD-FILE";
}
```

6. Restart nginx with `sudo systemctl nginx restart`
