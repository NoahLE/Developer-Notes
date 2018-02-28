---
title: Virtual Environment Reference
date: "2018-02-28"
publish: true
---


# Virtual Environments

Managing application versions between projects can be extremely frusterating. Thankfully, some developers have come up with a way of isolating each project to a specific set of application versions.

## Installation

There are a few ways one can use virtual environments, I usually use the `virtualenv` and the `virtualenvwrapper` method. 

## Environment Variables

Environment are an excellent way of keeping sensitive data out of code. They can be accessed in the following way:

```python
import os

# Produces KEYERROR if key not found
os.environ['NAME_OF_KEY']

# This will return None rather than KEYERROR if the key does not exist
os.getenviron.get('NAME_OF_KEY')

# This will return a default value if no key is found
os.getenv('NAME_OF_KEY', DEFAULT_VALUE)
```

### VirtualEnv

### VirtualEnv and VirtualenvWrapper

### PyEnv

## Usage

## Using VirtualEnvs in Jetbrains IDEs