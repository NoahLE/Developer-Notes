---
title: TypeScript Notes
date: "2018-03-05"
publish: true
---

## Variables

They can be the following formats:

* strings or template strings

* numbers (floating point)

* booleans

* arrays (collections of items of a single type)

* tuples(collections of different types of items)

* enum

```typescript
// let someVar: string = "hello"
let <varname>: <type> = <value>

// string example
let stringVar: string = "woof";

// template string example
// can span multiple lines
let name: string = `Hello ${your name}`;

// array example
// method 1
let list1: array = [1, 2, 3]
// method 2
let list2: Array<number> = [1, 2, 3]

// tuples example
let x: [string, number];
x = ["hello", 42]
// access elements with
let someItem = x[0]
// declare new items or current ones by doing the following:
x[3] = "something";
```