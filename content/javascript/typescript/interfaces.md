---
title: TypeScript - Interfaces
date: "2018-03-13"
publish: true
tags: ["javascript", "typescript"]
---

AKA `Duck typing` or `structural subtyping` focuses on the "shape" values have.

## Function checks

The code below requires the values that are given to it (notice the extra `size` attribute that isn't checked).

```typescript
// Using TypeScript
function printLabel(labelledObj: { label: string }) {
    console.log(labelledObj.label);
}

let myObj = {size: 10, label: "Size 10 Object"};
printLabel(myObj);

// Using TypeScript's `interface` instead
interface LabelledValue {
    label: string;
}

function printLabel(labelledObj: LabelledValue) {
    console.log(labelledObj.label);
}

let myObj = {size: 10, label: "Size 10 Object"};
printLabel(myObj);
```

If a value is optional, use a `?` in the interface declaration.

```typescript
// Declaring optional values
interface SquareConfig {
    color?: string;
    width?: number;
}

function createSquare(config: SquareConfig): {color: string; area: number} {
    let newSquare = {color: "white", area: 100};
    if (config.color) {
        newSquare.color = config.color;
    }
    if (config.width) {
        newSquare.area = config.width * config.width;
    }
    return newSquare;
}

let mySquare = createSquare({color: "black"});
```

If a value should be immutable (except for its creation), use `readonly`

```typescript
interface Point {
    readonly x: number;
    readonly y: number;
}

// The same can be done for arrays
let a: number[] = [1, 2, 3, 4];
let ro: ReadonlyArray<number> = a;
ro[0] = 12; // error!
```

**`const` is for variables, `readonly` is for properies of objects**

## Property checks

To avoid missspelling variable names in functions, they can be declared as well.

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
    // Add this to support additional unknown property types
    [propName: string]: any;
}

function createSquare(config: SquareConfig): { color: string; area: number } {
    // ...
}

// This produces an error
// error: 'colour' not expected in type 'SquareConfig'
let mySquare = createSquare({ colour: "red", width: 100 });
// This is the correct declaration
let mySquare = createSquare({ colour: "red", width: 100 });
// To bypass this check use
let mySquare = createSquare({ width: 100, opacity: 0.5 } as SquareConfig);
```

## Function types

When interfaces are used with functions, they describe the parameters and the return type. Note: the parameter names don't need to match.

```typescript
interface SearchFunc {
    // (param 1, param 2): return value
    (source: string, subString: string): boolean;
}

// A declared function
let mySearch: SearchFunc;
mySearch = function(source: string, subString: string) {
    let result = source.search(subString);
    return result > -1;
}

// Another way to declare the function
let mySearch: SearchFunc;
mySearch = function(src, sub) {
    let result = src.search(sub);
    return result > -1;
}

// An alternative way of declaring without using `interface`
let mySearch: SearchFunc;
// (param 1, param 2): return value
mySearch = function(src: string, sub: string): boolean {
    let result = src.search(sub);
    return result > -1;
}
```

## Indexable types

Index signatures means classifying the types that are indexed into an object as well as what their return values should be. Only `strings` and `numbers` are supported.

```typescript
// The array will only support strings
interface StringArray {
    [index: number]: string;
}

// Declaring the values in the string-only array
let myArray: StringArray;
myArray = ["Bob", "Fred"];

// The return value of the string
let myStr: string = myArray[0];
```

Indexes can be made read-only as well

```typescript
interface ReadonlyStringArray {
    readonly [index: number]: string;
}
let myArray: ReadonlyStringArray = ["Alice", "Bob"];
myArray[2] = "Mallory"; // error!
```

Be careful with inheritance!

> There are two types of supported index signatures: string and number. It is possible to support both types of indexers, but the type returned from a numeric indexer must be a subtype of the type returned from the string indexer. This is because when indexing with a number, JavaScript will actually convert that to a string before indexing into an object. That means that indexing with 100 (a number) is the same thing as indexing with "100" (a string), so the two need to be consistent.

```typscript
class Animal {
    name: string;
}
class Dog extends Animal {
    breed: string;
}

// Error: indexing with a numeric string might get you a completely separate type of Animal!
interface NotOkay {
    [x: number]: Animal;
    [x: string]: Dog;
}
```

## Class types

This is used for enforcing a class meeting a particular contract. Interfaces describe the public part of a class, function, or index.

```typescript
interface ClockInterface {
    // Describing the setTime method
    currentTime: Date;
    // Describing the method as a Date type
    setTime(d: Date);
}

class Clock implements ClockInterface {
    currentTime: Date;
    setTime(d: Date) {
        this.currentTime = d;
    }
    constructor(h: number, m: number) { }
}
```

### Difference between static and instance sides of classes

Classes have a static side (constructor) and an instance side (for each class that implements the interface).

```typescript
// For the constructor
interface ClockConstructor {
    new (hour: number, minute: number): ClockInterface;
}

// For the interface
interface ClockInterface {
    tick();
}

// For the constructor that creates instances (combines the interfaces above)
function createClock(ctor: ClockConstructor, hour: number, minute: number): ClockInterface {
    return new ctor(hour, minute);
}

class DigitalClock implements ClockInterface {
    constructor(h: number, m: number) { }
    tick() {
        console.log("beep beep");
    }
}

class AnalogClock implements ClockInterface {
    constructor(h: number, m: number) { }
    tick() {
        console.log("tick tock");
    }
}

let digital = createClock(DigitalClock, 12, 17);
let analog = createClock(AnalogClock, 7, 32);
```

## Extending interfaces

Extending interfaces allows for more modular code through inheritance.

```typescript
interface Shape {
    color: string;
}

interface PenStroke {
    penWidth: number;
}

interface Square extends Shape, PenStroke {
    sideLength: number;
}

let square = <Square>{};
square.color = "blue";
square.sideLength = 10;
square.penWidth = 5.0;

```

## Hybrid types

Sometimes objects can act as a function or an object. This is very useful when interacting with 3rd party libraries.

```typescript
interface Counter {
    (start: number): string;
    interval: number;
    reset(): void;
}

function getCounter(): Counter {
    let counter = <Counter>function (start: number) { };
    counter.interval = 123;
    counter.reset = function () { };
    return counter;
}

let c = getCounter();
c(10);
c.reset();
c.interval = 5.0;
```

## Interfaces extending classes

> When an interface type extends a class type it inherits the members of the class but not their implementations. It is as if the interface had declared all of the members of the class without providing an implementation. Interfaces inherit even the private and protected members of a base class. This means that when you create an interface that extends a class with private or protected members, that interface type can only be implemented by that class or a subclass of it.

> This is useful when you have a large inheritance hierarchy, but want to specify that your code works with only subclasses that have certain properties. The subclasses don’t have to be related besides inheriting from the base class. For example:

```typescript
class Control {
    // Since it is private, only descendants of Control will have 
    private state: any;
}

// Contains all members of Control (e.g. state)
interface SelectableControl extends Control {
    select(): void;
}

// 
class Button extends Control implements SelectableControl {
    select() { }
}

// Does not have 
class TextBox extends Control {
    select() { }
}

// Error: Property 'state' is missing in type 'Image'.
class Image implements SelectableControl {
    select() { }
}

class Location {

}
```

In the code above:

> Within the Control class it is possible to access the state private member through an instance of SelectableControl. Effectively, a SelectableControl acts like a Control that is known to have a select method. The Button and TextBox classes are subtypes of SelectableControl (because they both inherit from Control and have a select method), but the Image and Location classes are not.

## Sources

* [TypeScript documentation](https://www.typescriptlang.org/docs/handbook/interfaces.html)