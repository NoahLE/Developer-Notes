---
title: Django Notes
date: "2018-02-28"
publish: true
tags: ["python", "django"]
---

https://docs.djangoproject.com/en/1.11/

Abbreviation | Meaning
--- | ---
CM | Command
PN | Project name
AN | Application name
MN | Model name
EN | Virtualenv name
PR | Project root folder
AR | Application root folder

### Command line

command | description
--- | ---
`django-admin CM` | These commands can be run anywhere, as long as the `virtualenv` is active.
`python manage.py CM` | You must be in the same directory as this file to run it (app root)

combine the above with one of the commands below

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
MN.objects.all() | Queries all model names and returns the results
MN.objects.filter(id=#) | Filter an object's based on an attribute
MN.objects.get(pk=#) | get a specific item
q = MN(<model_field>="",) | Creates a new model which can be saved using `q.save()`
q.add(var), q.create(var), q.set(var) | add = add an object, create = make object, set = add multiple objects
`import datetime` | Useful time management library
`from django.utils import timezone` | Useful timezone conversion library

### Creating an app

Command | What it does
--- | ---
`./manage.py startapp AN` | creates an app
`project_root/settings.py` | add the app to `INSTALLED_APPLICATIONS`
`project_root/urls.py` | add the app urls

### Starting a project

In Pycharm, create a new project and set the interpreter to a new `virtualenv`.

If you're going  to use a terminal:

Command | What it does
--- | ---
`brew install python3` | Homebrew is a MacOS packager manager
`pip install virtualenv virtualenvwrapper` | installs environment managing tool
`mkvirtualenv EN` | create a virtual environment
`workon EN` | boot up virtualenv
`pip install django` | django in the virtualenv
`django-admin startproject PN` | creates the base project
`./manage-py runserver` | check if the server runs (must be in project root)

## Application folder

### admin.py

````
from django.contrib import admin

from .models import MN

class MNInline(admin.TabularInline) admin.StackedInline # tabular = large blocks, stackedinline = single row per entry
    model = MN
    extra = #

class MNAdmin(admin.ModelAdmin):
    fieldset = [
        (<title>, {'fields': ['field', 'field']}),
        (<title>, {'fields': ['field', 'field']}),
    ]
    inlines = [MNInline] # Add outside model as inline
    list_display = ('field', 'field', 'model_function') # columns to display for models
    list_filter = ['field'] # sidebar filter
    search_fields = ['field'] # searchbox for field

admin.site.register(MN, MNAdmin)
````

### models.py

https://docs.djangoproject.com/en/1.11/topics/db/examples/

- Abstract model = a place to store a common field among many tables. Does not actually create a table
- ManyToManyField = A pizza can have many toppings, and a topping may be on many pizzas
- Extends something to another model

````
from django.db import models


class ClassName(models.Model):
    SOME_CHOICES = (
        ('X', 'XX'),
        ('Y', 'YY'),
        ('Z', 'ZZ'),
    ) 
    # L side goes into database / R for readability
    # get_SOME_CHOICES_display() to show 2nd value

    var = models.CharField(
        "verbose name for field",
        max_length=5,
        default='aaa',
        blank=True,
        help_text='ahhhhhh',
        unique=True,
        )
    var1 = models.CharField(
        max_length=1, 
        choices=SOME_CHOICES
        )
    foreign_key = models.ForeignKey(
        <target_model>,
        on_delete=models.CASCADE,
        verbose_name='a related something',
        )
    many_to_many = models.ManyToManyField(<target_model>)
    many_to_many = models.ManyToManyField(
        <target_model>,
        through='Intermediate table', # can make your own if you would like to add extra data
        )
    #extending the user model
    from django.contrib.auth.models import User
    user = models.OneToOneField(User, on_delete=models.CASCADE)


    class Meta:
        ordering = ['-var']
        verbose_name = 'thing'
        verbose_name_plural = 'things'
        unique_together = (('dog', 'cat'),)

    __str__(self)
        return self.var

    def some_function(self):
        return self.somevar == timezone.now()

    def get_absolute_url(self):
        from django.urls import reverse
        return reverse('model.views.view_name', args=[str(self.id)])

# Abstract base model w/ child model
class AbstractBaseModel(models.Model):
    var = models.CharField(max_length=1)

    class Meta:
        abstract = true

class AbstractChildModel(AbstractBaseModel):
    var = models.CharField(max_length=1)

````

### urls.py

* url contents are always delivered as strings in the following format `(request, var, var, ...)`
* `(?P(<name>pattern))` = named groups
* capture groups can be nested
* `?:` = non-captured group
* name-spaced urls can be a best practice `<app>:<url>` when clashing url names. For example `admin:index` or `sports:polls:index`.


Reversing URLS in Python and Templates

````
from django.urls import reverse

year = 2006
reverse('url-name', args=(year,))
reverse('polls:index', current_app=self.request.resolver_match.namespace)


In templates, urls called via: {% url 'url-name' <vars> %}
For example: {% url 'stuff' 2012 %} or {% url 'polls:index' %}
````

The app_name variable or the following method can be used for namespacing

````
polls_patterns = ([
    url(r'^$', views.IndexView.as_view(), name='index'),
    url(r'^(?P<pk>\d+)/$', views.DetailView.as_view(), name='detail'),
], 'polls')
````

URL examples

````
from django.conf.urls import url, include

from . import views

# additional urls that can be added
extra_patterns = [
    url(r'^stuff/$', stuff_views.stuff),
]

# url examples
app_name = 'polls'
urlpatterns = [
    url(r'^$', views.index, name='index'),
    url('^stuff/', include(extra_patterns)),
    url(r'^articles/([0-9]{4})/$', views.article, name='stuff'), # capture values by surrounding in parentheses
    url(r'^articles/(?P<year>[0-9]{$4})/$', views.article, name='stuff'), # same as the above expression but with a named group
    url(r'contract/', include('django_website.contact.urls')),
    url(r'comments/(?:page-(?P<page_number>\d+)/)?$', comments), # returns page_number=2
]

# used for simplifing urls with the same base url
urlpatterns = [
    url(r'^(?P<page_slug>[w\-]+)-(?P<page_id>\w+)/, include([
        url(r'^history/$', views.history),
        url(r'^edit/$', views.edit),
        url(r'^discuss/$', views.discuss),
    ]))
]
````

### views.py

````
from django.http import HttpResponse
from django.view import generic

def index(request):
    return HttpResponse("Hello.")
    
def DetailView(generic.DetailView):
    model = MN
    template_name = 'AN/templates/AN/<file>.html'
    
    def get_queryset(self):
        return MN.objects.filter(name='?')
````

### *.html

````
<a href="{{ object.get_absolute_url }}">{{ object.name }}</a>
````

### templates

* It's generally good to have a base.html > base_SECTION.html > section.html template system

````
django.contrib.humanize
````

````
{% extends 'base.html' %} # must be first line of doc

{% block title %}
    {{ section.title }}
{% endblock %}

{% block story %}
    {% for story in story_list %}
        {% story.headline|upper %}
    {% endfor %}
{% endblock %}

{# some comment #}

{{ MODEL.FOREIGNKEY_set.all.count }}

{% if athlete_list|length > 1 %}
   Team: {% for athlete in athlete_list %} ... {% endfor %}
{% else %}
   Athlete: {{ athlete_list.0.name }}
{% endif %}
````

* an empty string is used if a variable is not found {{ var.attr }}
* filers = |var. for example {{ bio|truncatewords:30 }}{{ value|default:"nothing" }}
* others can be [found here](https://docs.djangoproject.com/en/1.11/ref/templates/builtins/#ref-templates-builtins-filters)

command | description
--- | ---
intcomma | adds commas to numbers
naturalday | yesterday, today, tomorrow for dates
naturaltime | takes string and returns how long ago it happened
ordinal | 1st, 2nd, 3rd from ints

## Project folder

### urls.py

````
from django.conf.urls import url, include
from django.contrib import admin
from django.http import HttpResponseRedirect

urlpatterns = [
    # e.g. myapp/
    url(r'^AN/', include(AN.urls')),
    # e.g. admin/
    url(r'^admin/', admin.site.urls),
    # e.g. /
    url(r'^$', lambda r: HttpResponseRedirect('AN/')),
]
````

### settings.py

````
INSTALLED_APPS = [
    'django_extensions',
    'AN.apps.ANConfig',
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
The settings file is in `PR/PF/settings.py`
You can edit your configurations in the top right. I recommend giving them names and only allowing single instances to run.
