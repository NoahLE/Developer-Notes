# Components

Components are the reusable parts of Vue. Data is passed through using props.

Components can use `data`, `computed`, `watch`, `methods`, and lifecycle hooks like other Vue instances. It cannot use `el` though.

## Scope

Globally registering all components is not ideal because it can increase build size.

```javascript
// global registration
Vue.component('my-component-name', {
  // ... options ...
})
```

Local components are not available to sub-components, unless specifically registered.

```javascript
// local registration
var ComponentA = { /* ... */ }

// making ComponentA available to ComponentB
var ComponentB = {
  components: {
    'component-a': ComponentA
  },

// the instance
new Vue({
  el: '#app'
  components: {
    'component-b': ComponentB
  }
})
```

ES2015+ would look like this

```javascript
import ComponentA from './ComponentA.vue'

export default {
  components: {
    ComponentA
  },
  // ...
}
```

### Base components

There are often components which are used in many parts of the project which are very simple. Like wrapped buttons or inputs.

It's very helpful to register these base components. That's why `require.context` was made.

```javascript
import Vue from 'vue'
import upperFirst from 'lodash/upperFirst'
import camelCase from 'lodash/camelCase'

const requireComponent = require.context(
  // The relative path of the components folder
  './components',
  // Whether or not to look in subfolders
  false,
  // The regular expression used to match base component filenames
  /Base[A-Z]\w+\.(vue|js)$/
)

requireComponent.keys().forEach(fileName => {
  // Get component config
  const componentConfig = requireComponent(fileName)

  // Get PascalCase name of component
  const componentName = upperFirst(
    camelCase(
      // Strip the leading `'./` and extension from the filename
      fileName.replace(/^\.\/(.*)\.\w+$/, '$1')
    )
  )

  // Register component globally
  Vue.component(
    componentName,
    // Look for the component options on `.default`, which will
    // exist if the component was exported with `export default`,
    // otherwise fall back to module's root.
    componentConfig.default || componentConfig
  )
})
```

## Events

Always use kebab-case (some-kebab-variable).

`v-model` can be used to make more intelligence state changes to children. For example, the checked state of a component.

```javascript
Vue.component('base-checkbox', {
  model: {
    prop: 'checked',
    event: 'change'
  },
  props: {
    checked: Boolean
  },
  template: `
    <input
      type="checkbox"
      v-bind:checked="checked"
      v-on:change="$emit('change', $event.target.checked)"
    >
  `
})
```

```html
<base-checkbox v-model="lovingVue"></base-checkbox>
```

When listening to normal events, it's possible to use the `.native` modifier for `v-on`. This can cause some problems though so `$listeners` is ideal.

```html
<!-- An example of .native -->
<base-input v-on:focus.native="onFocus"></base-input>
```

```javascript
// An example of $listeners
Vue.component('base-input', {
  inheritAttrs: false,
  props: ['label', 'value'],
  computed: {
    inputListeners: function () {
      var vm = this
      // `Object.assign` merges objects together to form a new object
      return Object.assign({},
        // We add all the listeners from the parent
        this.$listeners,
        // Then we can add custom listeners or override the
        // behavior of some listeners.
        {
          // This ensures that the component works with v-model
          input: function (event) {
            vm.$emit('input', event.target.value)
          }
        }
      )
    }
  },
  template: `
    <label>
      {{ label }}
      <input
        v-bind="$attrs"
        v-bind:value="value"
        v-on="inputListeners"
      >
    </label>
  `
})
```

Two-way data binding can cause issues, especially when it's between a parent and a child, so emitting events is usually a much better way to handle this.

```javascript
this.$emit('update:title', newTitle)
```

```html
<!-- updating based on an event -->
<text-document
  v-bind:title="doc.title"
  v-on:update:title="doc.title = $event"
></text-document>

<!-- the shorthand notation of the above snippet -->
<text-document 
  v-bind:title.sync="doc.title"
></text-document>

<!-- and being used with a v-bind -->
<text-document v-bind.sync="doc"></text-document>
```

## Examples

Here is an example to-do list.

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

It is possible to use a `v-for` directive on a component.

```html
<my-component v-for="item in items" :key="item.id"></my-component>
```

If passing data to the component, use this format:

```html
<my-component
    v-for="(item, index) in items"
    v-bind:item="item"
    v-bind:index="index"
    v-bind:key="item.id"
></my-component>
```

Here's a sample todo list:

```javascript
new Vue({
  el: '#todo-list-example',
  data: {
    newTodoText: '',
    todos: [
      {
        id: 1,
        title: 'Do the dishes',
      },
      {
        id: 2,
        title: 'Take out the trash',
      },
      {
        id: 3,
        title: 'Mow the lawn'
      }
    ],
    nextTodoId: 4
  },
  methods: {
    addNewTodo: function () {
      this.todos.push({
        id: this.nextTodoId++,
        title: this.newTodoText
      })
      this.newTodoText = ''
    }
  }
})
```

```html
<div id="todo-list-example">
  <form v-on:submit.prevent="addNewTodo">
    <label for="new-todo">Add a todo</label>
    <input
      v-model="newTodoText"
      id="new-todo"
      placeholder="E.g. Feed the cat"
    >
    <button>Add</button>
  </form>
  <ul>
    <li
      is="todo-item"
      v-for="(todo, index) in todos"
      v-bind:key="todo.id"
      v-bind:title="todo.title"
      v-on:remove="todos.splice(index, 1)"
    ></li>
  </ul>
</div>
```

An example counter button.

```javascript
// hooking into the template
// this is a global component registration
new Vue({ el: "#components-demo"})

// the logic
Vue.component('button-counter', {
  // data MUST be a function
  data: function(){
    return {
      count: 0
    }
  },
  template: '<button v-on:click="count++">You clicked me {{ count }} times.</button>'
})
```

```html
<div id="components-demo">
  <button-counter></button-counter>
</div>
```

## Props

Data is passed down using props in a one-way binding. Components are smart enough to merge class and style props.

```javascript
// as an array
Vue.component('blog-post', {
  props: ['title'],
  template: '<h3>{{ title }}</h3>'
})

// as an object
props: {
  title: String,
  likes: Number,
  isPublished: Boolean,
  commentIds: Array,
  author: Object
}
```

```html
<blog-post title="My journey with Vue"></blog-post>
<blog-post title="Blogging with Vue"></blog-post>
<blog-post title="Why Vue is so fun"></blog-post>
```

Using props with a for loop looks like this.

```javascript
new Vue({
  el: '#blog-post-demo',
  data: {
    posts: [
      { id: 1, title: 'My journey with Vue' },
      { id: 2, title: 'Blogging with Vue' },
      { id: 3, title: 'Why Vue is so fun' }
    ]
  }
})
```

```html
<blog-post
  v-for="post in posts"
  v-bind:key="post.id"
  v-bind:title="post.title"
></blog-post>
```

To keep props under control, you should pass an object to it instead.

```javascript
Vue.component('blog-post', {
  props: ['post'],
  template: `
    <div class="blog-post">
      <h3>{{ post.title }}</h3>
      <div v-html="post.content"></div>
    </div>
  `
})
```

```html
<blog-post
  v-for="post in posts"
  v-bind:key="post.id"
  v-bind:post="post"
></blog-post>
```

If a child component needs an initial value or to have it's inherited value transformed, one of the following actions should be done.

Remember that mutating an object or array will affect the parent (because of pass by reference).

```javascript
// initial value
props: ['initialCounter'],
data: function () {
  return {
    counter: this.initialCounter
  }
}

// inherited transformation
props: ['size'],
computed: {
  normalizedSize: function () {
    return this.size.trim().toLowerCase()
  }
}
```

Props can be fully type checked and validated as well.

```javascript
Vue.component('my-component', {
  props: {
    // Basic type check (`null` matches any type)
    propA: Number,
    // Multiple possible types
    propB: [String, Number],
    // Required string
    propC: {
      type: String,
      required: true
    },
    // Number with a default value
    propD: {
      type: Number,
      default: 100
    },
    // Object with a default value
    propE: {
      type: Object,
      // Object or array defaults must be returned from
      // a factory function
      default: function () {
        return { message: 'hello' }
      }
    },
    // Custom validator function
    propF: {
      validator: function (value) {
        // The value must match one of these strings
        return ['success', 'warning', 'danger'].indexOf(value) !== -1
      }
    }
  }
})
```

Custom constructors can be type checked as well for props.

```javascript
// the constructor
function Person (firstName, lastName) {
  this.firstName = firstName
  this.lastName = lastName
}

// the prop
Vue.component('blog-post', {
  props: {
    author: Person
  }
})
```

Undeclared attributes can still be added and accessible in the child element.

```html
<!-- data-date-picker will be availabe in the child -->
<bootstrap-date-input data-date-picker="activated"></bootstrap-date-input>
```

To manually set which proper are inherited, disable inheritance with `inheritAttrs` and use `$attrs` instead.

```javascript
Vue.component('base-input', {
  // disable inheritance
  inheritAttrs: false,
  props: ['label', 'value'],
  template: `
    <label>
      {{ label }}
      <input
        // use $attrs to grab the inherited values
        v-bind="$attrs"
        v-bind:value="value"
        v-on:input="$emit('input', $event.target.value)"
      >
    </label>
  `
})
```

```html
<base-input
  v-model="username"
  class="username-input"
  placeholder="Enter your username"
></base-input>
```

## Sending data to parent elements

In the state tracking the attribute which will be changes

```javascript
new Vue({
  el: '#blog-posts-events-demo',
  data: {
    posts: [/* ... */],
    postFontSize: 1
  },
  methods: {
    onEnlargeText: function (enlargeAmount) {
      this.postFontSize += enlargement
    }
  }
})
```

In the component, add the value that will change.

```html
<div id="blog-posts-events-demo">
  <div :style="{ fontSize: postFontSize + 'em' }">
    <blog-post
      v-for="post in posts"
      v-bind:key="post.id"
      v-bind:post="post"
      <!-- v-on:enlarge-text="postFontSize += $event" -->
      <v-on:enlarge-text="onEnlargeText"
    ></blog-post>
  </div>
</div>
```

And change the component to have the element that will change the value using `$emit`.

```javascript
Vue.component('blog-post', {
  props: ['post'],
  template: `
    <div class="blog-post">
      <h3>{{ post.title }}</h3>
      <-- The second value in emit is optional -->
      <button v-on:click="$emit('enlarge-text', 0.1)">
        Enlarge text
      </button>
      <div v-html="post.content"></div>
    </div>
  `
})
```

## Using v-model

It's possible to use `v-model` with components.

```javascript
Vue.component('custom-input', {
  props: ['value'],
  template: `
    <input
      v-bind:value="value"
      // note that it's not this: v-on:input="searchText = $event.target.value"
      v-on:input="$emit('input', $event.target.value)"
    >
  `
})
```

```html
<custom-input v-model="searchText"></custom-input>
```

## Slots

Slots are for passing things between html tags.

```html
<alert-box>Some text for the alert</alert-box>
```

```javascript
Vue.component('alert-box', {
  template: `
    <div class="demo-alert-box">
      <strong>Error!</strong>
      <slot></slot>
    </div>
  `
})
```

## Is

`is` allows for the switching of components. In the code below, the `v-bind:is=` allows for that value to be a component or an options object.

```html
<div id="dynamic-component-demo" class="demo">
  <button
    v-for="tab in tabs"
    v-bind:key="tab"
    v-bind:class="['tab-button', { active: currentTab === tab }]"
    v-on:click="currentTab = tab"
  >{{ tab }}</button>

  <component
    v-bind:is="currentTabComponent"
    class="tab"
  ></component>
</div>
```

```javascript
Vue.component('tab-home', {
  template: '<div>Home component</div>'
})
Vue.component('tab-posts', {
  template: '<div>Posts component</div>'
})
Vue.component('tab-archive', {
  template: '<div>Archive component</div>'
})

new Vue({
  el: '#dynamic-component-demo',
  data: {
    currentTab: 'Home',
    tabs: ['Home', 'Posts', 'Archive']
  },
  computed: {
    currentTabComponent: function () {
      return 'tab-' + this.currentTab.toLowerCase()
    }
  }
})
```

It's also good for nesting requirements such as `table` > `tr` or `ol` > `li`

```html
<table>
  <tr is="some-custom-component"></tr>
</table>
``` 