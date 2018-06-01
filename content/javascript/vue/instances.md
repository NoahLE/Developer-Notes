# Instances

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

## Instance lifecycle hooks

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
