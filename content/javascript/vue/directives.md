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

### v-model - Two-way data binding

```javascript
// This is great for form content
<p>{{ message }}</p>
<input v-model="message" placeholder="edit me">
```

#### Modifiers

Here are some modifiers included with `v-model`.

```html
<!-- synced after "change" instead of "input" -->
<input v-model.lazy="msg" >

<!-- to typecast the value as a number -->
<input v-model.number="age" type="number">

<!-- to automatically trim the message -->
<input v-model.trim="msg">
```

#### Forms

`v-model` will ignore initial values of `value`, `checked`, or `selected` (the inital value should be declared in the `data` section of your component.

This is an example using checkboxes.

```html
<div id='example-3'>
  <input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
  <label for="jack">Jack</label>
  <input type="checkbox" id="john" value="John" v-model="checkedNames">
  <label for="john">John</label>
  <input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
  <label for="mike">Mike</label>
  <br>
  <span>Checked names: {{ checkedNames }}</span>
</div>
```

```javascript
new Vue({
  el: '#example-3',
  data: {
    checkedNames: []
  }
})
```

Using radio buttons.

```html
<input type="radio" id="one" value="One" v-model="picked">
<label for="one">One</label>
<br>
<input type="radio" id="two" value="Two" v-model="picked">
<label for="two">Two</label>
<br>
<span>Picked: {{ picked }}</span>
```

Using select.

```html
<select v-model="selected">
  <option disabled value="">Please select one</option>
  <option>A</option>
  <option>B</option>
  <option>C</option>
</select>
<span>Selected: {{ selected }}</span>
```

```javascript
new Vue({
  el: '...',
  data: {
    //   Because of how iOS behaves, it is recommended to have a disabled option with an empty value like below.
    selected: ''
  }
})
```

Using select with items generated from a `v-for` loop.

```html
<select v-model="selected">
  <option v-for="option in options" v-bind:value="option.value">
    {{ option.text }}
  </option>
</select>
<span>Selected: {{ selected }}</span>
```

```javascript
new Vue({
  el: '...',
  data: {
    selected: 'A',
    options: [
      { text: 'One', value: 'A' },
      { text: 'Two', value: 'B' },
      { text: 'Three', value: 'C' }
    ]
  }
})
```

Multiselect example

```html
<select v-model="selected" multiple>
  <option>A</option>
  <option>B</option>
  <option>C</option>
</select>
<br>
<span>Selected: {{ selected }}</span>
```

Somes it's useful to bind other values to fields.

Such as checkboxes:

```javascript
// when checked:
vm.toggle === 'yes'
// when unchecked:
vm.toggle === 'no'
```

```html
<input
  type="checkbox"
  v-model="toggle"
  true-value="yes"
  false-value="no"
>
```

Radio buttons:

```html
<input type="radio" v-model="pick" v-bind:value="a">
```

```javascript
// when checked:
vm.pick === vm.a
```

And selects

```javascript
// when selected:
typeof vm.selected // => 'object'
vm.selected.number // => 123
```

```html
<select v-model="selected">
  <!-- inline object literal -->
  <option v-bind:value="{ number: 123 }">123</option>
</select>
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

### Event listeners

The `v-on` directive is used for listening to events.

```javascript
var example1 = new Vue({
    el: "#example1",
    data: {
        counter: 0
    }
})

```html
<div id="example1">
    <button v-on:click="counter += 1">Add 1</button>
    <p>The button above has been clicked {{ counter }} times.</p>
</div>
```

It's much more practical to include the logic in a method call though.

```javascript
var example2 = new Vue({
    el: "#example2",
    data: {
        name: "Vue.js"
    },
    methods: {
        greet: function(event) {
            alert("Hello " + this.name + "!")
            if (event){
                alert(event.target.tagName)
            }
        }
    }
})

// If you want to invoke the method in JavaScript
example2.greet()
```

```html
<div id="example2">
    <button v-on:click="greet">Greet</button>
</div>
```

It possible to pass variables to the methods as well

```html
<div id="example-3">
  <button v-on:click="say('hi')">Say hi</button>
  <button v-on:click="say('what')">Say what</button>
</div>
```

```javascript
new Vue({
  el: '#example-3',
  methods: {
    say: function (message) {
      alert(message)
    }
  }
})
```

Here's how to access the original DOM even in an inline statement.

```html
<button v-on:click="warn('Form cannot be submitted yet.', $event)">
  Submit
</button>
```

```javascript
methods: {
  warn: function (message, event) {
    // now we have access to the native event
    if (event) event.preventDefault()
    alert(message)
  }
}
```

To keep event listeners to just data logic, it's possible to offload DOM logic onto the listener itself

```html
.stop
.prevent
.capture
.self
.once
.passive

<!-- the click event's propagation will be stopped -->
<a v-on:click.stop="doThis"></a>

<!-- the submit event will no longer reload the page -->
<form v-on:submit.prevent="onSubmit"></form>

<!-- modifiers can be chained -->
<!-- the order does matter -->
<a v-on:click.stop.prevent="doThat"></a>

<!-- just the modifier -->
<form v-on:submit.prevent></form>

<!-- use capture mode when adding the event listener -->
<!-- i.e. an event targeting an inner element is handled here before being handled by that element -->
<div v-on:click.capture="doThis">...</div>

<!-- only trigger handler if event.target is the element itself -->
<!-- i.e. not from a child element -->
<div v-on:click.self="doThat">...</div>

<!-- the click event will be triggered at most once -->
<a v-on:click.once="doThis"></a>

<!-- the scroll event's default behavior (scrolling) will happen -->
<!-- immediately, instead of waiting for `onScroll` to complete  -->
<!-- in case it contains `event.preventDefault()`                -->
<!-- this is great for improving mobile device support -->
<div v-on:scroll.passive="onScroll">...</div>
```

### Key Modifiers

Key events are based on `keycodes`, custom `keycodes` or aliases.

```html
<!-- only call `vm.submit()` when the `keyCode` is 13 -->
<input v-on:keyup.13="submit">

<!-- same as above -->
<input v-on:keyup.enter="submit">

<!-- also works for shorthand -->
<input @keyup.enter="submit">
```

Setting a custom `keycode`.

```javascript
// enable `v-on:keyup.f1`
Vue.config.keyCodes.f1 = 112
```

It's possible to tap into `KeyboardEvent.key`.

```html
<!-- the event handler -->
$event.key === 'PageDown'

<!-- tap into it by using -->
<input @keyup.page-down="onPageDown">
```

Here's a full list of aliases

```html
.enter
.tab
.delete (delete and backspace)
.esc
.space
.up
.down
.left
.right
```

It's possible to listen to key combinations as well.

```html
.ctrl
.alt
.shift
.meta (cmd on mac, ctrl on windows)

<!-- Alt + C -->
<input @keyup.alt.67="clear">

<!-- Ctrl + Click -->
<div @click.ctrl="doSomething">Do something</div>
```

To have events fired only when these keys are pressed, use `.exact`.

```html
<!-- this will fire even if Alt or Shift is also pressed -->
<button @click.ctrl="onClick">A</button>

<!-- this will only fire when Ctrl and no other keys are pressed -->
<button @click.ctrl.exact="onCtrlClick">A</button>

<!-- this will only fire when no system modifiers are pressed -->
<button @click.exact="onClick">A</button>
```

Mice have a couple listeners too.

```javascript
.left
.right
.middle
```