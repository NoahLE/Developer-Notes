# Vue Router

## Examples

The application template

```html
<div id="app">
  <h1>Hello App!</h1>
  <p>
    <!-- Use router-link component for navigation. Specify the link by passing the `to` prop. -->
    <router-link to="/foo">Go to Foo</router-link>
    <router-link to="/bar">Go to Bar</router-link>
  </p>
  <!-- Component matched by the route will render here -->
  <router-view></router-view>
</div>
```

The base Vue file

```javascript
// Import VueRouter
Vue.use(VueRouter)

// 1. Define route components.
const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }

// 2. Define some routes
const routes = [
  { path: '/foo', component: Foo },
  { path: '/bar', component: Bar }
]

// 3. Create the router instance and pass the `routes` option
const router = new VueRouter({
    // short for `routes: routes`
    routes
})

// 4. Create and mount the root instance.
const app = new Vue({
  router
}).$mount('#app')
```

An example component file

## Sources

* [Documentation](https://router.vuejs.org/)