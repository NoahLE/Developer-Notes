# Edge-Cases

The `new Vue` instance can be grabbed by using `this.$root`. Using Vuex is much better for handling things like this though.

To access a parent component `this.$parent` can be used. Passing data through `props` would be a much better solution for this.

To access child elements, the `ref` attribute can be used. `ref`s are not reactive and are only generated on render.

Vue offers other methods to listen to its events interface:

* `$on(eventName, eventHandler)` - listen for an event
* `$once(eventName, eventHandler)` - listen for an event only once
* `$off(eventName, eventHandler)` - stop listening for an event

Components can recursively call themselves, but they need a unique `name`. If a component references another component in a circular reference, using import asynchronously can be very helpful (`TreeFolderComponents: () => import('./tree-folder-contents.vue'`)

```html
<!-- a ref attribute to access the childs -->
<base-input ref="usernameInput"></base-input>

<input ref="input">
```

```javascript
// this is how it's accessed in the parent component
this.$refs.usernameInput

// this is used to focus the input from the parent
methods: {
    focus: function () {
        this.$refs.input.focus()
    }
}

// which would call focus on the base input using this
this.$refs.usernameInput.focus()
```

When trying to access grandparents or grandchildren, it's ideal to use dependency injection. The downside of this is it couples components based on the structure of the application. The properties are also not reactive, so Vuex could be an ideal solution for this.

`provide` - specify the data / methods to provide to descendant components

`inject` - specify the properties to add to the instance

```javascript
provide: function () {
  return {
    getMap: this.getMap
  }
}

inject: ['getMap']
```

This is a programmatic listener that's only used once and is excellent for working with third party libraries that need to be created and destoryed.

```javascript
mounted: function () {
  var picker = new Pikaday({
    field: this.$refs.input,
    format: 'YYYY-MM-DD'
  })

  this.$once('hook:beforeDestroy', function () {
    picker.destroy()
  })
}

mounted: function () {
  this.attachDatepicker('startDateInput')
  this.attachDatepicker('endDateInput')
},
methods: {
  attachDatepicker: function (refName) {
    var picker = new Pikaday({
      field: this.$refs[refName],
      format: 'YYYY-MM-DD'
    })

    this.$once('hook:beforeDestroy', function () {
      picker.destroy()
    })
  }
}
```

## Resources

* [Edge case documentation](https://vuejs.org/v2/guide/components-edge-cases.html)