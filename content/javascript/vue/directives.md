# Directives

Directives are special attributes with the `v-` prefix. They are a single JavaScript expression which reactively apply side effects to the DOM when the value of its expression changes.

Some directives can take an arguement which comes after the colon.

```javascript
// Example directive arguements
<a v-bind:href="url">...</a>
<a v-on:click="doSomething">...</a>
```

Modifiers are denoted by a dot and indicate the directive should be bound in some special way.

```html
<form v-on:submit.prevent="onSubmit">...</span>
```

## Directive Shorthands

### `v-bind`

```html
<a v-bind:href="url">...</a>
<!-- turns into -->
<a :href="url">...</a>
```

### `v-on`

```html
<a v-on:click="doSomething">...</a>
<!-- turns into -->
<a @click="doSomething">...</a>
```

## Directive Examples

### Dynamic content and titles

```javascript
<div id="somediv">
    <span v-bind:title="message">{{ message }}</span>
</div>
```

### For loops

A quick example

```html
<ol>
    <li v-for="todo in todos">
        {{ todo.text }}
    </li>
</ol>
```

You can use `of` instead of `in`

```html
<div v-for="item of items"></div>
```

A larger `v-for` example

```html
<!-- A simple for loop -->
<ul id="example1">
    <li v-for="item in items">
        {{ item.message }}
    </li>
</ul>
```

```javascript
// The instance side
var example1 = new Vue({
    el: "#example1",
    data: {
        item: [
            { message: "Foo" },
            { message: "Bar" }
        ]
    }
})
```

Index and accessing attributes outside of `v-for`

```html
<!-- The template code -->
<ul id="example2">
    <li v-for="(item, index) in items">
        {{ parentMessage }} - {{ index }} - {{ item.message }}
    </li>
</ul>
```

```javascript
// The instance side
var example2 = new Vue({
    el: "#example2",
    data: {
        parentMessage: "Parent",
        items: [
            { message: "Foo" },
            { message: "Bar" }
        ]
    }
})
```

Iterating though an object

```html
<!-- Using an object's value -->
<ul id="v-for-object" class="demo">
    <li v-for="value in object">
        {{ value }}
    </li>
</ul>

<!-- Using an object's key and value -->
<div v-for="(value, key) in object">
    {{ key }}: {{ value }}
</div>

<!-- Using an index as well as an object's key and value -->
<div v-for="(value, key, index) in object">
    {{ index }}. {{ key }}: {{ value }}
</div>
```

```javascript
// The instance
new Vue({
    el: "#v-for-object",
    data: {
        object: {
            firstName: "Bob",
            lastName: "Loblaw",
            age: 30
        }
    }
})
```

*Note: Key order is based on the enumeration of `Object.keys()` which may be different based on the JavaScript engine used*

### Function calls

```javascript
<p>{{ message }}</p>
<button v-on:click="reverseMessage">Reverse</button>
```

### Two-way data binding

```javascript
// This is great for form content
<p>{{ message }}</p>
<input v-model="message">
```

### Including raw HTML

```javascript
// Any bindings in the HTML will be ignored
// NEVER TRUST USER CONTENT
<p>Using a directive: <span v-html="rawHTML"></span></p>
```

### Only update the content once

```javascript
<span v-once>This will never change: {{ message }}</span>
```