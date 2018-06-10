# Components

Components are the reusable parts of Vue. Data is passed through using props.

Components can use `data`, `computed`, `watch`, `methods`, and lifecycle hooks like other Vue instances. It cannot use `el` though.

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

Data is passed down using props.

```javascript
Vue.component('blog-post', {
  props: ['title'],
  template: '<h3>{{ title }}</h3>'
})
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