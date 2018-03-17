---
title: TypeScript - Variable Declarations
date: "2018-03-08"
publish: true
tags: ["javascript", "typescript"]
---

## Variable Declarations

Variables can be declared using `var`, `let`, and `const`.

### Var

`var` is the default JavaScript declaration method with some quirks.

```javascript
var x = 10;
```

Variables declared using `var` can be accessed outside of the functions they were declared in. This includes the file, namespace, and global namespace, which is prone to cause problems.

```javascript
function f() {
    var a = 10;
    return function g() {
        var b = a + 1;
        return b;
    }
}

var g = f();
g(); // returns '11'
```

They also return as soon as the first return function is called like in the example below.

```javascript
function f() {
    var a = 1;

    a = 2;
    var b = g();
    a = 3;

    return b;

    function g() {
        return a;
    }
}

f(); // returns '2'
```

### IIFE - Immediately Invoked Function Expression

In the example below, the code will output `10`, ten times rather than `0, 1, ..., 9` because the `setTimeout` function will not execute until the for loop is done. Because of this, all executions of the console.log command will reference the same `i`.

```javascript
for (var i = 0; i < 10; i++) {
    setTimeout(function() { console.log(i); }, 100 * i);
}
```

To work around this, surround the `setTimeout` function in an IIFE to capture the value of `i` during each execution.

```JavaScript
for (var i = 0; i < 10; i++) {
    // capture the current state of 'i'
    // by invoking a function with its current value
    (function(i) {
        setTimeout(function() { console.log(i); }, 100 * i);
    })(i);
}
```

## let

`let` is very similar to `var`, but has a lot of the quirks worked out.

```typescript
// An example let declaration
let x = 10;
```

Variables declared are not accessible outside of their function block or loop.

```typescript
function f(input: boolean) {
    let a = 100;

    if (input) {
        // Still okay to reference 'a'
        let b = a + 1;
        return b;
    }

    // Error: 'b' doesn't exist here
    return b;
}
```

They must be declared before they are operated on.

```typescript
a++; // illegal to use 'a' before it's declared;
let a;
```

Variables can't be redeclared if they're within the same scope.

```typescript
let x = 10;
let x = 20; // error: can't re-declare 'x' in the same scope

function f(x) {
    let x = 100; // error: interferes with parameter declaration
}

function g() {
    let x = 100;
    var x = 100; // error: can't have both declarations of 'x'
}
```

A block-scoped variable can be declared from a function-scoped variable. It needs to be in a seperate block to work through (see example).

```typescript
function f(condition, x) {
    if (condition) {
        let x = 100;
        return x;
    }

    return x;
}

f(false, 0); // returns '0'
f(true, 0);  // returns '100'
```

Variable shadowing should be avoided (declaring variables within nested blocks, even though they are protected by `let`).

```typescript
function sumMatrix(matrix: number[][]) {
    let sum = 0;
    for (let i = 0; i < matrix.length; i++) {
        var currentRow = matrix[i];
        for (let i = 0; i < currentRow.length; i++) {
            sum += currentRow[i];
        }
    }

    return sum;
}
```

In the example below, the `city` variable is still accessible because it is associated with the `getCity` variable in scope above it. TLDR; even after a scope has finished executing, the variables can still be accessed.

```typescript
function theCityThatAlwaysSleeps() {
    let getCity;

    if (true) {
        let city = "Seattle";
        getCity = function() {
            return city;
        }
    }

    return getCity();
}
```

## const

`const` variables cannot be reassigned after being declared. This does not mean they are immutable.

```typescript
const numLivesForCat = 9;
const kitty = {
    name: "Aurora",
    numLives: numLivesForCat,
}

// Error
kitty = {
    name: "Danielle",
    numLives: numLivesForCat
};

// all "okay"
kitty.name = "Rory";
kitty.name = "Kitty";
kitty.name = "Cat";
kitty.numLives--;
```

## Destructuring / Unpacking

This allows the user to quickly take apart the components of an object or variable.

### Arrays

```typescript
let input = [1, 2];
let [first, second] = input;
console.log(first); // outputs 1
console.log(second); // outputs 2

// The above code is the same as doing this
first = input[0];
second = input[1];

// It can be used with pre-existing variables as well
[first, second] = [second, first];

// An in with function parameters
function f([first, second]: [number, number]) {
    console.log(first);
    console.log(second);
}
f([1, 2]);

// You can catch all the remaining variables using `...`
let [first, ...rest] = [1, 2, 3, 4];
console.log(first); // outputs 1
console.log(rest); // outputs [ 2, 3, 4 ]

// Or cut off the variables you don't wish to use
let [first] = [1, 2, 3, 4];
let [, second, , fourth] = [1, 2, 3, 4];
console.log(first); // outputs 1
```

### Objects

```typescript
// Objects can be destructed as well
let o = {
    a: "foo",
    b: 12,
    c: "bar"
};
let { a, b } = o;

// Objects can be unpacked without declaration (notice the parenthesis)
({ a, b } = { a: "baz", b: 101 });

// Catching the rest of the variables works for object unpacking as well
let { a, ...passthrough } = o;
let total = passthrough.b + passthrough.c.length;

// Properties can be renamed when unpacking as well
let { a: newName1, b: newName2 } = o;
// Which is the same as
let newName1 = o.a;
let newName2 = o.b;

// When unpacking, the type is declared using the following syntax:
let { a, b }: { a: string, b: number } = o;
```

### Function Declarations


```typescript
type C = { a: string, b?: number }
function f({ a, b }: C): void {
    // ...
}
```

## Default Values

Notice the `b?` to declare that the variable is not required.

```typescript
function keepWholeObject(wholeObject: { a: string, b?: number }) {
    let { a, b = 1001 } = wholeObject;
}
```

With functions, it gets a little more complicated

```typescript
// Be cafeful with using this as it can be very confusing
function f({ a, b } = { a: "", b: 0 }): void {
    // ...
}
f(); // ok, default to { a: "", b: 0 }

// And to make things even more confusing
function f({ a, b = 0 } = { a: "" }): void {
    // ...
}
f({ a: "yes" }); // ok, default b = 0
f(); // ok, default to { a: "" }, which then defaults b = 0
f({}); // error, 'a' is required if you supply an argument
```

## Spread operators

Spreading is the opposite of destructuring. It allows you to add variables into another object. One caveat objects that come later in the operation overwrite earlier declarations (see code for an example).

```typescript
// Spreading an array
let first = [1, 2];
let second = [3, 4];
let bothPlus = [0, ...first, ...second, 5];
```

Objects spread later overwrite earlier declarations of the same variable.

```typescript
// Spreading objects
// food is "rich"
let defaults = { food: "spicy", price: "$$", ambiance: "noisy" };
let search = { ...defaults, food: "rich" };

// food is "spicy"
let defaults = { food: "spicy", price: "$$", ambiance: "noisy" };
let search = { food: "rich", ...defaults };
```

Objects that are spread lose their enumerable properties.

```typescript
class C {
  p = 12;
  m() {
  }
}
let c = new C();
let clone = { ...c };
clone.p; // ok
clone.m(); // error!
```

## Sources

- [TypeScript Documentation](https://www.typescriptlang.org/docs/handbook/variable-declarations.html)