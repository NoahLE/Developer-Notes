---
title: Python Snippets
date: "2018-04-11"
publish: true
tags: ["python"]
---

## Variables

Quick swap

```python
a, b = b, a
```

## Functions

(realpython) arguement unpacking

```python
def myfunc(x, y, z):
    print(x, y, z)

tuple_vec = (1, 0, 1)
dict_vec = {'x': 1, 'y': 0, 'z': 1}

>>> myfunc(*tuple_vec)
1, 0, 1

>>> myfunc(**dict_vec)
1, 0, 1
```

## Objects

(realpython) returning a default value for a missing dictionary key

```python
# The get() method on dicts
# and its "default" argument

name_for_userid = {
    382: "Alice",
    590: "Bob",
    951: "Dilbert",
}

def greeting(userid):
    return "Hi %s!" % name_for_userid.get(userid, "there")

>>> greeting(382)
"Hi Alice!"

>>> greeting(333333)
"Hi there!"
```

(realpython) sorting a dictionary

```python
# How to sort a Python dict by value

>>> xs = {'a': 4, 'b': 3, 'c': 2, 'd': 1}
>>> sorted(xs.items(), key=lambda x: x[1])
    "[('d', 1), ('c', 2), ('b', 3), ('a', 4)]"
```

## JSON

(realpython) printing objects

```python
>>> import json
>>> print(json.dumps(
        {'a': 1, 'b': 2},
        indent=4,
        sort_keys=True))

>>> {
        "a": 1,
        "b": 2
    }
```

## Links

* [RealPython](https://realpython.com/)
