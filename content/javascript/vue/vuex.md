# Vuex

Vuex is a way of tracking the state of an application. This is an excellent way to have a single source of truth for an application.

## To do

* Testing section

* Hot reloading section

## Notes

When the state changes, Vue components that are subscribed to it change as well.

The store cannot be directly mutated. Instead, committing `mutations` cause the store to update.

Strict mode throws errors the state is mutated outside of mutation handlers. Do not use in production!

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

To handle a form in strict mode, the code would look something like the code below. 
A lot of `v-model` functionality is lost so the second code example may be more ideal.

```html
<!-- the form -->
<input :value="message" @input="updateMessage">
```

```javascript
// the mutation call
computed: {
    ...mapState({
        message: state => state.obj.message
    })
},
methods: {
    updateMessage(e) {
        this.$store.commit('updateMessage', e.target.value)
    }
}

// the mutation handler
mutations: {
    updateMessage (state, message){
        state.obj.message = message
    }
}
```

To solve the same problem by using a two-way computed property would look like this.

```html
<input v-model="message">
```

```javascript
computed: {
    message: {
        get () {
            return this.$store.state.obj.message
        },
        set (value) {
            this.$store.commit('updateMessage', value)
        }
    }
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

## Modules

Modules are a way to break applications up into parts. This is excellent for handling large applications. Each module can hold the state, mutations, actions, getters, and other modules.

```javascript
const moduleA = {
    // setting the initial local state
    state: { count: 0 },
    mutations: {
        increment (state) {
            state.count++
        }
    },
    actions: {
        // local state = context.state
        // root state = context.rootState
        incrementIfOddOnRootSum({ state, commit, rootState }) {
            if ((state.count + rootState.count) % 2 === 1) {
                commit('increment')
            }
        }
    },
    getters: {
        doubleCount (state) {
            return state.count * 2
        },
        // the third argument will always be the root state
        sumWithRootCount(state, getters, rootState) {
            return state.count + rootState.count
        }
    }
}

const moduleB = {
    state: {...},
    mutations: {...},
    actions: {...},
    getters: {...}
}

const store = new Vuex.Store({
    modules: {
        a: moduleA,
        b: moduleB
    }
})

// getting values from the different states
store.state.a
store.state.b
```

Names are by default namespaced unless the `namespaced` variable is used.

```javascript
const store = new Vuex.Store({
  modules: {
    account: {
      namespaced: true,

      // module state is already nested and not affected by namespace option
      state: { ... },
      getters: {
        // getters['account/isAdmin']
        isAdmin () { ... }
      },
      actions: {
        // dispatch('account/login')
        login () { ... }
      },
      mutations: {
        // commit('account/login')
        login () { ... }
      },

      // nested modules
      modules: {
        // inherits the namespace from parent module
        myPage: {
          state: { ... },
          getters: {
            // getters['account/profile']
            profile () { ... }
          }
        },

        // further nest the namespace
        posts: {
          namespaced: true,

          state: { ... },
          getters: {
            // getters['account/posts/popular']
            popular () { ... }
          }
        }
      }
    }
  }
})
```

To access global assets such as state and getters, use `rootState` and `rootGetter`. To dispatch actions or mutations pass `{ root: true }`.

```javascript
modules: {
  foo: {
    namespaced: true,

    getters: {
      someGetter (state, getters, rootState, rootGetters) {
        // 'foo/someOtherGetter'
        getters.someOtherGetter
        // 'someOtherGetter' = this will access a global getter
        rootGetters.someOtherGetter
      },
      someOtherGetter: state => { ... }
    },

    actions: {
      // dispatch and commit are also localized for this module
      // they will accept `root` option for the root dispatch/commit
      someAction ({ dispatch, commit, getters, rootGetters }) {
        getters.someGetter // -> 'foo/someGetter'
        rootGetters.someGetter // -> 'someGetter'

        dispatch('someOtherAction') // -> 'foo/someOtherAction'
        dispatch('someOtherAction', null, { root: true }) // -> 'someOtherAction'

        commit('someMutation') // -> 'foo/someMutation'
        commit('someMutation', null, { root: true }) // -> 'someMutation'
      },
      someOtherAction (ctx, payload) { ... }
    }
  }
}
```

To register a global namespaced action in a module, use `root: true`

```javascript
{
  actions: {
    someOtherAction ({dispatch}) {
      dispatch('someAction')
    }
  },
  modules: {
    foo: {
      namespaced: true,

      actions: {
        someAction: {
          root: true,
          handler (namespacedContext, payload) { ... } // -> 'someAction'
        }
      }
    }
  }
}
```

When using things like `mapState`, `mapActions`, and other methods, it's possible to use a namespace to simplify the import.

```javascript
computed: {
  // the namespaced module
  ...mapState('some/nested/module', {
    // a: state => state.some.nested.module.a,
    a: state => state.a,
    // b: state => state.some.nested.module.b
    b: state => state.b
  })
},
methods: {
  // the namespaced module
  ...mapActions('some/nested/module', [
    // 'some/nested/module/foo',
    'foo',
    // 'some/nested/module/bar'
    'bar'
  ])
}
```

To make things even easier, `createNamespacedHelpers` was made.

```javascript
import { createNamespacedHelpers } from 'vuex'

const { mapState, mapActions } = createNamespacedHelpers('some/nested/module')

export default {
  computed: {
    // look up in `some/nested/module`
    ...mapState({
      a: state => state.a,
      b: state => state.b
    })
  },
  methods: {
    // look up in `some/nested/module`
    ...mapActions([
      'foo',
      'bar'
    ])
  }
}
```

Modules can be dynamically added after the store had been created. They can be removed as well using `store.unregisterModule(moduleName)`. To keep the state use `preserveState`.

```javascript
// these modules, are available as store.state.myModule and store.state.nested.myModule

// register a module `myModule`
store.registerModule('myModule', {
  // ...
})

// register a nested module `nested/myModule`
store.registerModule(['nested', 'myModule'], {
  // ...
})
```

Module reuse

```javascript
const MyReusableModule = {
  state () {
    return {
      foo: 'bar'
    }
  },
  // mutations, actions, getters...
}
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

## Plugins

Plugins accept the store and exposes a hook for each mutation. They cannot directly mutate the state, but do so by committing mutations.

```javascript
const myPlugin = store => {
    // called when the store is inialized
    store.subscribe((mutation, state) => {
        // called after every mutation (formatted like `{ type, payload }`)
    })
}

// plugins are added like this
const store = new Vuex.Store({
    plugins: [myPlugin]
})
```

A sample update using websockets.

```javascript
// the code for the plugin
export default function createWebSocketPlugin(socket) {
    return store => {
        socket.on('data', data => {
            store.commit('receivedData', data)
        })
        store.subscribe(mutation => {
            socket.emit('update', mutation.payload)
        })
    }
}

// initializing the plugin
const webSocketPlugin = createWebSocketPlugin(socket);

const store = new Vuex.Store({
    state,
    mutations,
    plugins: [plugin]
})
```

To create a state snapshot and compare the differences between the two, the code would look something like this.

```javascript
const myPluginWithSnapshot = store => {
    let prevState = _.cloneDeep(store.state)
    store.subscribe((mutation, state) => {
        let nextState = _.cloneDeep(state)
        // compare the states here

        // update to the next state
        prevState = nextState
    })
}
```

To use a snapshot only during development, use something like this.

```javascript
const store = new Vuex.Store({
    plugins: process.env.NODE_ENV !== 'production'
        ? [myPluginWithSnapshot]
        : []
})
```

## Resources

* [Vuex Documentation](https://vuex.vuejs.org/)