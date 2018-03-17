---
title: Python Classes
date: "2018-02-28"
publish: true
tags: ["python"]
---

## A sample class

```python
class Vehicle:
    kind = 'car'

    def __init__(self, manufacturer, model):
        self.manufacturer = manufacturer
        self.model_name = model

    @property
    def name(self):
        return "%s %s" % (self.manufacturer, self.model_name)

    def __repr__(self):
        return "<%s>" % self.name
```

## Accessing class attributes

```python
car = Vehicle('Toyota', 'Corolla')
print(car, car.kind)
```

## Changing values

Changing class variables affects all instances. It is a good rule to avoid them unless this behavior is intended.

Creating the objects

```python
>>> car = Vehicle('Toyota', 'Corolla')
>>> car2 = Vehicle('Honda', 'Civic')

>>> car.kind, car2.kind
('car', 'car')
```

Changing the class variables

```python
>>> Vehicle.kind = 'scrap'

>>> car.kind, car2.kind
('scrap', 'scrap')
```

Change the class variable from the instance

```python
>>> car.kind = 'scrap'
>>> car.kind, car2.kind
('scrap', 'car')
```

Listing all class variables

```python
>>> car.__dict__
{'manufacturer': 'Toyota', 'model_name': 'Corolla'}
```

## Sources

- https://rushter.com/blog/python-class-internals/