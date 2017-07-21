# Django Notes

Abbreviation | Meaning
--- | ---
CM | Command
PN | Project name
AN | Application name
EN | Virtualenv name
PR | Project root folder
AR | Application root folder

### Command line

command | description
--- | ---
`django-admin <CM>` | These commands can be run anywhere, as long as the `virtualenv` is active.
`python manage.py <CM>` | You must be in the same directory as this file to run it (app root)

combine with one of the commands below:

command | description
---|----
startapp | creates a new app (inside the project)
createsuperuser| this user has been granted all permissions
runserver | runs the development web server
shell_plus | runs an enhanced python shell
migrate | applies migrations to the database
makemigrations | makes db migration files
dbshell | connects to the database | 
cleanup| cleans up the database

### shell_plus commands
command|description
--- | ---
<MN>.objects.all() | Queries all model names and returns the results
<MN>.objects.filter(id=#) | Filter an object's based on an attribute
<MN>.objects.get(pk=#) | get a specific item
q = <MN>(<model_field>="",) | Creates a new model which can be saved using `q.save()`
`import datetime` | Useful time management library
`from django.utils import timezone` | Useful timezone conversion library

### Creating an app

Command | What it does
--- | ---
`./manage.py startapp <AN>` | creates an app
`project_root/settings.py` | add the app to `INSTALLED_APPLICATIONS`
`project_root/urls.py` | add the app urls

### Starting a project

In Pycharm, create a new project and set the interpreter to a new `virtualenv`.

If you're going  to use a terminal:

Command | What it does
--- | ---
`brew install python3` | Homebrew is a MacOS packager manager
`pip install virtualenv virtualenvwrapper` | installs environment managing tool
`mkvirtualenv <EN>` | create a virtual environment
`workon <EN>` | boot up virtualenv
`pip install django` | django in the virtualenv
`django-admin startproject <PN>` | creates the base project
`./manage-py runserver` | check if the server runs (must be in project root)

## Application folder

### models.py

````
from django.db import models


class <ClassName>(models.Model):
    var = models.CharField(max_length=5, default='aaa')
    foreign_key = models.ForeignKey(<target_model>, on_delete=cascade)
    
    __str__(self)
        return self.var
        
    def some_function(self):
        return self.somevar == timezone.now()
````

### urls.py

````
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
]
````

### views.py

````
from django.http import HttpResponse

def index(request):
    return HttpResponse("Hello.")
````

## Project folder

### urls.py

````
from django.conf.urls import url, include
from django.contrib import admin
from django.http import HttpResponseRedirect

urlpatterns = [
    # e.g. myapp/
    url(r'^<AN>/', include(<AN>.urls')),
    # e.g. admin/
    url(r'^admin/', admin.site.urls),
    # e.g. /
    url(r'^$', lambda r: HttpResponseRedirect('<AN>/')),
]
````

### settings.py

````
INSTALLED_APPS = [
    'django_extensions',
    '<AN>.apps.<AN>Config',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
````


## Webstorm

### Setting up a server script
`Languages > Frameworks > Django` - check enable django support
The settings file is in `<PR>/<PF>/settings.py`
You can edit your configurations in the top right. I recommend giving them names and only allowing single instances to run.