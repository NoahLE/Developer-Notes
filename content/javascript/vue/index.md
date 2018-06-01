# Initial notes for Vue.js

## Other reference pages

* [Instances](instances.md) - Vue view model declarations
* [Directives](directives.md) - Prefixes (`v-`) which control component and template logic
* [Components](components.md) - Reusable parts of Vue which contain presentational logic
* [Templates](templates.md) - The mustache syntax for rendering content in templates

## Initial app example

```javascript
var app = new Vue({
    // Element to attach to based on class or id
    el: "#somediv"
    // The app data
    data: {
        message: "The time is " + new Date().toLocaleString(),
        todos: [
            { text: "Hello" },
            { text: "One" },
            { text: "Two" },
            { text: "Three" }
        ]
    },
    methods: {
        reverseMessage: function () {
            this.message = this.message.split("").reverse.join("")
        }
    }
})
```

## Computed Properties

Computed properties are for offloading template logic in the application. They are very similar to methods.

The key difference is computed properties are cached based on their dependencies, methods always run the function.

```javascript
// Template
<div id="example">
    <p>Original message: "{{ message }}"</p>
    <p>Computed reversed message: "{{ reversedMessage }}"</p>
</div>

// Instance
var vm = new Vue({
    el: "#example",
    data: {
        message: "Hello"
    },
    computed: {
        reversedMessage: function () {
            return this.message.split("").reverse().join("")
        }
    }
})
```

## Watched Property

Use `watch` sparingly and in many cases it's better to use computed property instead. Watchers are great for asynchronous or expensive operations though.

```javascript
// The template
<div id="watch-example">
    <p>
        Ask a yes/no question:
        <input v-model="question">
    </p>
    <p>{{ answer }}</p>
</div>
```

```javascript
// The instance
// Requires axios and lodash
var watchExampleVM = new Vue({
    el: "#watch-example",
    data: {
        question: "",
        answer: "I cannot give you an answer until you ask a question"
    },
    watch: {
        question: function(newQuestion, oldQuestion) {
            this.answer = "Waiting for you to stop typing"
            this.debouncedGetAnswer()
        }
    },
    created: function() {
        this.debouncedGetAnswer = _.debounce(this.getAnswer, 500)
    },
    methods: {
        getAnswer: function () {
            if (this.question.indexOf("?") === -1) {
                this.answer = "Questions usually contain a question mark. :P"
                return
            }
            this.answer = "Thinking..."
            var vm = this
            axios.get("https://yesno.wtf/api")
                .then(function (response) {
                    vm.answer = _.capitolize(response.data.answer)
                })
                .catch(function(error){
                    vm.answer = "Error! Could not reach the API." + error
                })
        }
    }
})
```

## Computed Setter

Computed properties are getter-only be default, but declaring setters are possible. In the example below, updating vm.fullName = "John Doe" would also set `vm.firstName` and `vm.lastName`.

```javascript
// rest of the instance code
computed: {
    fullName: {
        get: function() {
            return this.firstName + " " + this.lastName
        },
        set: function(newValue) {
            var names = newValue.split(" ")
            this.firstName = names[0]
            this.lastName = names[names.length - 1]
        }
    }
}
```

## Class and Style Bindings

Vue has helpful logic for handling classes and inline style bindings.

```html
<!-- The active class will exist if isActive is true -->
<div
    class="static"
    v-bind:class="{
        active: isActive,
        'text-danger': hasError
    }">
</div>
```

Make sure the instance has the following snippet:

```javascript
...,
data: {
    isActive: true,
    hasError: false
}
```

Alternatively, the classes can be an object

```javascript
// The template
<div v-bind:class="classObject"></div>

// The instance object
data: {
    classObject: {
        active: true,
        'text-danger': false
    }
}
```

Computed properties are possible as well

```javascript
data: {
    isActive: true,
    error: null
},
computed: {
    classObject: function() {
        return {
            active: this.isActive && !this.error,
            'text-danger': this.error && this.error.type === 'fatal'
        }
    }
}
```

It's possible to send arrays to elements as well

```javascript
// To render this
<div class="active text-danger"></div>

// Use this markup
<div v-bind:class="[activeClass, errorClass]"></div>

// And this code
data: {
    activeClass: "active",
    errorClass: "text-danger"
}

// Using a ternary operator
<div v-bind:class="[isActive ? activeClass : '', errorClass]"></div>

// Using object syntax (same as the ternay operator)
<div v-bind:class="[{active: isActive}, errorClass]"></div>
```

### Inline styling

Inline styling is very similar to its CSS counterpart.

```javascript
// Purely inline
// Template code
<div v-bind:style="{ color: activeColor, fontSize: fontSize + 'px'}"></div>

// Instance code
data: {
    activeColor: "red",
    fontSize: 30
}
```

It's cleaner to use an object directly so the template is cleaner.

```javascript
// Inline using an object
// Template code
<div v-bind:style="styleObject"></div>

// Instance code
data: {
    styleObject: {
        color: "red",
        fontSize: "13px"
    }
}
```

Vendor prefixes will be used based on what the browser supports.

```html
<div v-bind:style="{ display: ['-webkit-box', '-ms-flexbox', 'flex'] }"></div>
```

### Classes with Components

Existing classes will not be overwritten and the new classes will be added.

```javascript
// The base component
Vue.component("my-component", {
    template: "<p class='foo bar'>Hi</p>"
})

// Adding additional classes
<my-component class="baz boo"></my-component>

// Which renders
<p class="foo bar baz boo">Hi</p>

// Using a class
<my-component v-bind:class="{ active: isActive }"></my-component>

// Will render
<p class="foo bar active">Hi</p>
```

## Conditional Logic

### If statements

If statements can be done in handlebar templates or as a directive. Any `else` or `else-if` statements must immediately follow the `if` statement.

```javascript
// Handlebars
{{ #if ok }}
    <h1>Hi</h1>
{{ /if }}

// Vue directive
<h1 v-if="ok">Hi</h1>

// Including Else
<h1 v-if="ok">Hi</h1>
<h1 v-else>Bye</h1>
```

If you want to affect multiple elements, wrap them in another component.

```javascript
// Using just 'if'
<template v-if="ok">
    <h1>Title</h1>
    <p>Paragraph 1</p>
    <p>Paragraph 2</p>
</template>

// Using an 'else' block too
<div v-if="Math.random() > 0.5">
    Now you see me
</div>
<div v-else>
    Now you don't
</div>
```

An `else-if` example.

```javascript
<div v-if="type === 'A'">
    A
</div>
<div v-else-if="type === 'B'">
    B
</div>
<div v-else>
    Not A or B
</div>
```

### Using `key`

Normally data between fields is saved. In the code below, the username will be saved between fields because only the placeholder text will update.

```javascript
<template v-if="loginType === 'username'">
    <label>Username</label>
    <input placeholder="Enter your username"/>
</template>
<template v-else>
    <label>Email</label>
    <input placeholder="Enter your email address">
<template>
```

To generate a completely new field, use the key value.

```javascript
<template v-if="loginType === 'username'">
  <label>Username</label>
  <input placeholder="Enter your username" key="username-input">
</template>
<template v-else>
  <label>Email</label>
  <input placeholder="Enter your email address" key="email-input">
</template>
```

### v-show Directive

`v-show` is very similar to `v-if` but is not supported in `<template>` elements or by `v-else`.

`v-show` is always rendered, but only displayed if true (higher render cost), while `v-if` is rendered every time its value becomes true (higher toggle cost).

```html
<h1 v-show="ok">Hello</h1>
```

## Vocabulary

* directive - prefixed with `v-` and are special attributes provided for Vue
* component - an abstraction of a large-scale application to allow small, self-contained, and reusable building blocks to be used. These are formed into a tree of components.

## Reference

A quick command reference

Command | Definition
--- | ---
v-bind | Keeps element up-to-date with the element it's bound to
v-if | If `true` show it, otherwise don't
v-for | Does a for loop for each element in the array
v-on:click | When the action is performed it does the required method
v-model | Two-way data binding to keep a variable in sync