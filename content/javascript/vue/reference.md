# Initial notes for Vue.js

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

## Example component

Components are the reusable parts of Vue. Data is passed through using props.

```javascript
// Declare the component
Vue.component("todo-item", {
    props: ["todo"],
    template: "<li>{{ todo.text }}</li>"
});

// Create data for the component
var app = new Vue({
    el: "#someApp",
    data: {
        someArray: [
            { id: 0, text: "1"},
            { id: 0, text: "2"},
            { id: 0, text: "3"}
        ]
    }
})

// The HTML side
<div id="someApp">
    <ol>
        <todo-item
            v-for="item in someArray"
            v-bind:todo="item"
            v-bind:key="item.id"
        >
        </todo-item>
    </ol>
```

## Example directives

The page with dynamic content

```javascript
<div id="somediv">
    <span v-bind:title="message">{{ message }}</span>
</div>
```

With a for loop

```javascript
<ol>
    <li v-for="todo in todos">
        {{ todo.text }}
    </li>
</ol>
```

With actions that call a function

```javascript
<p>{{ message }}</p>
<button v-on:click="reverseMessage">Reverse</button>
```

With two-way data binding

```javascript
// This is great for form content
<p>{{ message }}</p>
<input v-model="message">
```

## Instances

An instance is usually declared as `vm` (for view model). All options are available in the [API docs](https://vuejs.org/v2/api/#Options-Data).

The Vue instance will only react if the data existed when the instance was created. The fix for this is to declare the variables beforehand, even if they don't have a values.

```javascript
// You initialize data
var data = {
    a: 1,
    someOtherVar: "",
    aNumber: null,
    anArray: []
}
var vm = new Vue({
    data: data
})

// Will react and update
data.a = 2

// Will not react or update
data.b = 2
```

Vue has a lot of instance properties and methods which are prefixed with `$`

```javascript
var data = { a: 1 }
var vm = new Vue({
    el: "#example",
    data: data
})

vm.$data === data
vm.$el === document.getElementById("example")

vm.$watch("a", function(newValue, oldValue){
    // This will be called when `vm.a` changes
})
```

Using the freeze method will prevent existing properties from being updated under any circumstance.

```javascript
var obj = {
    foo: "bar"
}

Object.freeze(obj);

new Vue({
    <p>{{ foo }}</p>
    // This will not work
    <button v-on:click="foo = 'baz'">Change it</button>
})
```

### Instance lifecycle hooks

These are Vue's lifecycle hooks

* beforeCreate
* created
* beforeMount
* mounted
* beforeUpdate
* updated
* beforeDestroy
* destroyed

![lifecycle](lifecycle.png)

Do not use arrow functions for a property or callback

```javascript
new Vue({
    data: {
        a: 1
    },
    created: function(){
        // `this` points to the VM instance
        console.log("a is: " + this.a)
    },
    // DO NOT DO THIS
    // created: () => console.log(this.a)
    // DO NOT DO THIS
    // vm.$watch("a", newValue => this.myMethod())
})
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