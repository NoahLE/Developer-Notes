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

## State

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

## Mutations

Mutations have a type and a handler. The handler performs the state modifications.

Its best practice to send an object for an arguement to a mutator.

Mutations must by synchronous.

```javascript
const store = new Vuex.Store({
    state: {
        count: 1
    },
    mutations: {
        // the state is always the first argument it receives
        increment (state) {
            // mutate the state
            state.count++
        },
        superIncrement (state, n) {
            state.count += n
        },
        // THIS IS BEST PRACTICE
        superDuperIncrement (state, payload) {
            state.count += payload.amount
        }
    }
})
```

To call a mutation, you must invoke it's handler like so:

```javascript
store.commit('increment')
store.commit('increment', 10)
store.commit('superDuperIncrement', { amount: 10})
// THIS IS BEST PRACTICE
store.commit({
    type: 'increment',
    amount: 10
})
```

Mutations can be brought into components by using `this.$store.commit('...')` or `mapMutations`.

```javascript
import { mapMutations } from 'vuex'

export default {
    methods: {
        ...mapMutations([
            // this.increment === this.$store.commit('increment')
            'increment',
            // this.incrementBy === this.$store.commit('incrementBy', amount)
            'incrementBy'
        ]),
        ...mapMutations([
            // this.add() === this.$store.commit('increment')
            add: 'increment'
        ])
    }
}
```

## Actions

Actions are like mutations, but can work asynchronously. Mutations change the state, while actions commit changes.

```javascript
const store = new Vuex.Store({
    state: {
        count: 0
    },
    mutations: {
        increment (state) {
            state.count++
        }
    },
    // the es5 way to do things
    actions: {
        increment ({ commit }) {
            commit('increment')
        }
    }
    // the vanilla method
    actions: {
        increment (context) {
            context.commit('increment')
        }
    }
})
```

Actions receive all the state information through `context.state` and the getter methods through `context.getters`.

Actions are triggered using the `dispatch` method.

```javascript
actions: {
    incrementAsync ({ commit  }) {
        setTimeout(() => {
            commit('increment')
        }, 1000)
    }
}
```

And actually doing something.

```javascript
store.dispatch('incrementAsync', { amount: 10 })
store.dispatch({ type: 'incrementAsync', amount: 10 })
```

If calling an API, it would look something like this:

```javascript
actions: {
    checkout ({ commit, state }, products) {
        // save the items in the cart
        const savedCartItems = [...state.cart.added]
        // send the checkout request and clear the items
        commit(types.CHECKOUT_REQUEST)
        shop.buyProducts(
            products,
            // if success
            () => commit(types.CHECKOUT_SUCCESS)
            // if failure
            () => commit(types.CHECKOUT_FAILURE, savedCartItems)
        )
    }
}
```

If using a component it inherits by using `mapActions`.

```javascript
import { mapActions } from 'vuex'

export default {
    methods: {
        ...mapActions([
            // this.increment() === this.$store.dispatch('increment')
            'increment',
            'incrementBy'
        ]),
        ...mapActions([
            // this.add() === this.$store.dispatch('increment')
            add: 'increment'
        ])
    }
}
```

Using `await` and `async` in actions.

```javascript
actions: {
    async actionA ({ commit }) {
        commit('gotData', await getData())
    },
    async actionB ({ dispatch, commit }) {
        await dispatch('actionA')
        commit('gotOtherData', await getOtherData())
    }
}
```

Since actions are asynchronous, they return a Promise. This great for when multiple actions have been dispatched.

```javascript
actions: {
    actionA ({ commit }) {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                commit('someMutation')
                resolve()
            }, 1000)
        })
    },
    actionB ({ dispatch, commit }) {
        return dispatch('actionA').then(() => {
            commit('someOtherMutation')
        })
    }
}
```

So `then`...

```javascript
store.dispatch('actionA').then(() => {
    // ...
})
```

## Caveats

* Initialize your state will all desired fields upfront to make them reactive

* When adding new properties to an object, use: `Vue.set(obj, 'new prop', 123)` or `state.obj = { ...state.obj, newProp: 123 }`.

## Constants

Constants can be helpful for quickly showing developers what actions are available in large projects. They can also tie into linters nicely. It is purely an OPTIONAL choice though.

A file which contains all constants.

```javascript
// mutation-types.js
// constants.js
export const SOME_MUTATION = 'SOME_MUTATION'
```

The actual use of the constants.

```javascript
import Vuex from 'vuex'
import { SOME_MUTATION } from './mutation-types'

const store = new Vuex.Store({
    state: {...},
    mutations: {
        [SOME_MUTATION] (state) {
            // mutation stuff
        }
    }
})
```

## Resources

* [Vuex Documentation](https://vuex.vuejs.org/)