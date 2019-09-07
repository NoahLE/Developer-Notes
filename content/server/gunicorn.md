# GUnicorn Notes

## Setup

Install the required dependencies using the following command.

```bash
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools python3-venv
```

## Sample Python Virtual Environment Setup

1. Create a virtualenv using `python3 -m venv PROJ-NAMEenv`

2. Start the virtualenv with `source PROJ-NAMEenv/bin/active`

## Sample Flask Setup

1. With the virtual environment activated, install the required dependencies with `pip install wheel` then `pip install gunicorn flask`

2. Create a sample Flask application

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "<h1 style='color:blue'>Hello There!</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
```

3. Create a WSGI management file

```python
from myproject import app

if __name__ == "__main__":
    app.run()
```

4. Create a service file in `/etc/systemd/system/` so the project will run when the server starts

```bash
[Unit]
Description=Gunicorn instance to serve myproject
After=network.target

[Service]
User=USER
Group=www-data
WorkingDirectory=/home/USER/PROJECT-NAME
Environment="PATH=/home/USER/PROJECT-NAME/PROJECT-NAMEenv/bin"
ExecStart=/home/USER/PROJECT-NAME/PROJECT-NAMEenv/bin/gunicorn --workers 3 --bind unix:PROJECT-NAME.sock -m 007 wsgi:app

[Install]
WantedBy=multi-user.target
```

5. Start and enable the project with `sudo systemctl start PROJECT-NAME` and `sudo systemctl enable PROJECT-NAME`

## Enabling NGinx to Proxy Requests to GUnicorn

1. In the config file for your NGinx website (`/etc/nginx/sites-available/SITE-NAME`), add the following section:

```bash
    location / {
        include proxy_params;
        proxy_pass http://unix:/home/sammy/myproject/myproject.sock;
    }
```

2. Check the configuration with `sudo nginx -t`

3. Restart NGinx `sudo systemctl restart nginx`

4. Test!

## Source

- [Digital Ocean - Flask Nginx Gunicorn](https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-18-04)
