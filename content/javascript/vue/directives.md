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

Vue observes arrays to see if they have the following modifications performed on them:

```javascript
// Mutate the array
push()
pop()
shift()
unshift()
splice()
sort()
reverse()

// Always return a new array
filter()
concat()
slice()
```

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

It's ideal to use a key to track items when looping through them.

```html
<div v-for="item in items" :key="item.id">
    <!-- content -->
</div>
```

To sort or filter an array without changing the values of the original array computed properties work best.

```html
<li v-for="n in evenNumbers">{{ n }}</li>
```

```javascript
data: {
    numbers: [1, 2, 3, 4, 5]
},
computed: {
    evenNumbers: function() {
        return this.numbers.filter(function (number){
            return number %  2 === 0
        })
    }
}
```

If computed properties are not an option, methods are good as well.

```html
<li v-for="n in even(numbers)">{{ n }}</li>
```

```javascript
data: {
    numbers: [1, 2, 3, 4, 5]
},
methods: {
    even: function(numbers){
        return numbers.filter(function (number){
            return number % 2 === 0
        })
    }
}
```

`range` can be used to easily increment values

```html
<div>
    <span v-for="n in 10">{{ n }}</span>
</div>
```

`v-for` blocks can of course be rendered in templates as well.

```html
<!-- Show only incomplete items -->
<ul>
    <template v-for="item in items">
        <li>{{ item.msg }}</li>
        <li class="divider" role="presentation"></li>
    </template>
</ul>

<!-- To skip execution if a condition is not met -->
<ul v-if="todos.length">
    <li v-for="todo in todos">
        {{ todo }}
    </li>
<ul>
<p v-else>No todos left</p>
```

If you would like to filter items in a loop, it is possible to combine `v-for` and `v-if`.

```html
<li v-for="todo in todos" v-if="!todo.isComplete">
    {{ todo }}
</li>
```

#### Caveats

Vue cannot detect the following changes to an array when its length is modified or the value of an index is directly set.

```javascript
var vm = new Vue({
    data: {
        items: ['a', 'b', 'c']
    }
})

// Directly setting the value of an index
vm.items[1] = 'x'
// Changing the length of the array
vm.items.length = 2
```

This can be bypassed by using the following methods.

```javascript
// Setting a new value
Vue.set(vm.items, indexOfItem, newValue)
// Changing the length of the array
vm.items.splice(newLength)
```

It cannot detect property additions or deletions.

```javascript
var vm = new Vue({
    data: {
        a: 1
    }
}) // a is reactive
vm.b = 2 // b is not reactive
```

This can be bypassed by using the `set` or `$set` methods.

```javascript
var vm = new Vue({
    data: {
        userProfile: {
            name: 'Anika'
        }
    }
})

Vue.set(vm.userProfile, 'age' 27)
vm.$set(vm.userProfile, 'age', 27)
```

If adding multiple properties `assign` is usually the easiest way to do this.

```javascript
Object.assign(vm.userProfile, {
    age: 27,
    favoriteColor: 'Vue green'
})

vm.userProfile = Object.assign({}, vm.userProfile, {
    age: 27,
    favoriteColor: 'Vue green'
})
```

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