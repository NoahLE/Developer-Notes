---
title: Vanilla Django Setup
date: "2018-04-29"
publish: true
tags: ["python", "django"]
---

# Quick Django Setup Notes

This is a quick guide to setting up Django using `startproject`. I would highly recommend looking into using [Django Cookie Cutter](https://github.com/pydanny/cookiecutter-django) though.

## Set up the enviroment

1. Create a virtual environment for the project (if you're using `virtualenv + virtualenv-wrapper` the command is `mkvirtualenv project_name`)
2. Install Django with `pip3 install django`
3. Make the source project folder with `django-admin startproject project_name`
4. Test the install with `python manage.py runserver`

## Make a new app view and hook it up

1. Make the app with `python manage.py startapp app_name`
2. Add the view

```python
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")
```

3. Add the view to the URLS

```python
from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
```

4. Add the app url to the main project

```python
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('polls/', include('polls.urls')),
    path('admin/', admin.site.urls),
]
```

5. Add the app to the `INSTALLED_APPS` in `settings.py`.

## Setting up the database

1. If using SQLite (default) run `python manage.py makemigrations` and `python manage.py migrate`.

2. If using a custom database, you should create the database and hook it up in the `settings.py` file.

