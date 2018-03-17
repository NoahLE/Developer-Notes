---
title: TypeScript - Variables
date: "2018-03-05"
publish: true
tags: ["javascript", "typescript"]
---

## Variables

```typescript
// let someVar: string = "hello"
let <varname>: <type> = <value>
```

They can be the following formats:

* strings or template strings

```typescript
// string example
let stringVar: string = "woof";

// template string example
// can span multiple lines
let name: string = `Hello ${your name}`;
```

* numbers (floating point)

```typescript
// string example
let someNum: number = 3.14;
```

* booleans

```typescript
// boolean example
let unsure: boolean = true;
```

* arrays (collections of items of a single type)

```typescript
// array example
// method 1
let list1: array = [1, 2, 3]
// method 2
let list2: Array<number> = [1, 2, 3]
```

* tuples(collections of different types of items)

```typescript
// tuples example
let x: [string, number];
x = ["hello", 42]
// access elements with
let someItem = x[0]
// declare new items or current ones by doing the following:
x[3] = "something";
```

* enum (gives names to numeric values - starts at 0 by default)

```typescript
// enum example
// the line below is the same as: 
// enum Color {Red = 1, Green = 2, Blue = 4}
enum Color {Red, Green, Blue}
let c: Color = Color.Green;
```

* any

```typescript
// any example
let notSure: any = 4;
notSure = "Is now a string.";
```

* void (must be undefined or null)

```typescript
// void example
let unusable: void = undefined;
```

* null and undefined (subtypes of other types, eg null can be assigned to a number)

```typescript
// null example
let u: undefined = undefined;
let u: null = null;
```

* never (for a function that always throws an exception or never returns)

```typescript
// Function returning never must have unreachable end point
function error(message: string): never {
    throw new Error(message);
}

// Inferred return type is never
function fail() {
    return error("Something failed");
}

// Function returning never must have unreachable end point
function infiniteLoop(): never {
    while (true) {
    }
}
```

* type assertions

```typescript
let someValue: any = "this is a string";

// type angled-bracket syntax
let strLength: number = (<string>someValue).length;

// type as syntax
let strLength: number = (someValue as string).length;
```