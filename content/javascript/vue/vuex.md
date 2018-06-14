# Vuex

Vuex is a way of tracking the state of an application. This is an excellent way to have a single source of truth for an application.

## Notes

When the state changes, Vue components that are subscribed to it change as well.

The store cannot be directly mutated. Instead, committing `mutations` cause the store to update.

## Example

Initalizing the store.

```javascript
// Import Vuex
import Vuex from 'vuex'

// Inject the store into all child components
// Available as this.$store in children
Vue.use(Vuex)

const app = new Vue({
    el: '#app',
    store,
    components: {Counter},
    template: `
    <div class="app">
        <counter></counter>
    </div>
    `
})

// Initializing the store
const store = new Vuex.Store({
    state: {
        count: 0
    },
    // ways to change the state
    mutations: {
        increment (state) {
            state.count++
        }
    }
})
```

A sample component

```javascript
// the easiest way to update components based on state changes
const Counter = {
    template: `<div>{{ count }}</div>`,
    computed: {
        count() {
            return $store.state.count
        }
    }
}
```

Accessing the state and triggering a state change.

```javascript
// Changing the state of the store
store.commit('increment')

// Get the current of value in the state
store.state.count
```

Getting multiple store properties can be annoying so `mapState` was created.

```javascript
import { mapState } from 'vuex'

export default {
    computed: mapState({
        // set count to the count value in the state
        count: state => state.count,
        // a shortcut for the above line
        countAlias: 'count',
        // access the local state of a component
        countPlusLocalState(state){
            return state.count + this.localCount
        }
    })
}
```

When the name of a mapped computed property is the same as a state sub tree name, it can be passed as a string.

```javascript
computed: mapState([
    // this.count === store.state.count
    'count'
])
```

The spread operator is excellent for combining state objects.

```javascript
computed: {
    localComputed () {},
    ...mapState({})
}
```

## Getters

Getting a derived state based on the store state is impractical. `getters` are a much better way to do this. The `getter` below is accessible through `store.getters.<getter_method>`.

```javascript
computed: {
    doneTodosCount () {
        // DO THIS
        return this.$store.getters.doneTodosCount

        // DON'T DO THIS
        return this.$store.state.todos.filter(todo => todo.done).length
    }
}
```

Here's how `getters` are declared.

```javascript
// Use getters instead to calculate this
// The first arguements for getters is the state
// The second arguement is other getters
const store = new Vuex.Store({
    state: {
        todos: [
            { id: 1, text: '...', done: true }
            { id: 2, text: '...', done: false }
        ]
    },
    getters: {
        // Returns done todos
        doneTodos: state => {
            return state.todos.filter(todo => todo.done)
        },
        // Returns done todos count
        doneTodosCount: (state, getters) => {
            return getters.doneTodos.length
        }
    }
})
```

Arguments can be passed to getters by returning a function. This is excellent for things like querying an array.

```javascript
// Passing an argument to a getter
getters: {
    getTodosById: (state) => (id) => {
        return state.todos.find(todo => todo.id === id)
    }
}

// The call to the getter which passes an argument
// Returns the todo based on its ID
store.getters.getTodoById(2)
```

Like `...mapState`, there's also a `...mapGetters`.

```javascript
import { mapGetters } from 'vuex'

export default {
    computed: {
        ...mapGetters([
            'doneTodosCount',
            'anotherGetter',
            // to give a getter another name, use this syntax
            doneCount: 'doneTodosCount'
        ])
    }
}
```

## Resources

- [Vuex Documentation](https://vuex.vuejs.org/)