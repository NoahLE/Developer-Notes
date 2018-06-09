# Components

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