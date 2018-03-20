---
title: TypeScript - Classes
date: "2018-03-19"
publish: true
tags: ["javascript", "typescript"]
---

Traditional JavaScript used prototype-based inheritance. TypeScript uses the more familiar object-oriented programming.

```typescript
class Greeter {
    // A property
    greeting: string;

    // The constructor
    constructor(message: string) {
        // this.____ means it has member access
        this.greeting = message;
    }

    // A method
    greet() {
        return "Hello, " + this.greeting;
    }
}

let greeter = new Greeter("world");
```

## Inheritance

Classes can inherit properties and methods from other classes. The classes which are deriving from other classes are called *subclasses* and the class they inherit from are called *superclasses*.

```typescript
class Animal {
    move(distanceInMeters: number = 0) {
        console.log(`Animal moved ${distanceInMeters}m.`);
    }
}

class Dog extends Animal {
    bark() {
        console.log('Woof! Woof!');
    }
}

const dog = new Dog();
dog.bark();
dog.move(10);
dog.bark();
```

And here is a more complex example.

```typescript
class Animal {
    name: string;
    constructor(theName: string) { this.name = theName; }
    move(distanceInMeters: number = 0) {
        console.log(`${this.name} moved ${distanceInMeters}m.`);
    }
}

class Snake extends Animal {
    // Super must always be called when inheriting from a superclass
    // Super should always come first in derived classes
    constructor(name: string) { super(name); }
    move(distanceInMeters = 5) {
        console.log("Slithering...");
        super.move(distanceInMeters);
    }
}

class Horse extends Animal {
    // Again, make sure to use super
    constructor(name: string) { super(name); }
    move(distanceInMeters = 45) {
        console.log("Galloping...");
        super.move(distanceInMeters);
    }
}

let sam = new Snake("Sammy the Python");
let tom: Animal = new Horse("Tommy the Palomino");

sam.move();
tom.move(34);
```

## Public, private, and protected modifiers

Class members are public by default. When comparing two members, they must have the type, eg, `public` must be compared with `public`, `private` with `private`, and `protected` with `protected`.

Here is an example using `public` based on the previous code:

```typescript
class Animal {
    public name: string;
    public constructor(theName: string) { this.name = theName; }
    public move(distanceInMeters: number) {
        console.log(`${this.name} moved ${distanceInMeters}m.`);
    }
}
```

If a member is marked private, it cannot be accessed outside a class.

```typescript
class Animal {
    private name: string;
    constructor(theName: string) { this.name = theName; }
}

new Animal("Cat").name; // Error: 'name' is private;
```

When comparing members, they must be of the same type.

```typescript
class Animal {
    private name: string;
    constructor(theName: string) { this.name = theName; }
}

class Rhino extends Animal {
    constructor() { super("Rhino"); }
}

class Employee {
    private name: string;
    constructor(theName: string) { this.name = theName; }
}

let animal = new Animal("Goat");
let rhino = new Rhino();
let employee = new Employee("Bob");

animal = rhino;
animal = employee; // Error: 'Animal' and 'Employee' are not compatible
```