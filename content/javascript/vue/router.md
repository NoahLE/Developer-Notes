# Vue Router

Routes are a very powerful system based on regexes and will resolve in the order they are declared.

The dynamic parts of a URL can be retrieved using `params`.

If a component is reused for a similar route, lifecycle hooks will not be called. To work around this, `watch` the `$route` or use `beforeRouteUpdate`.

## Examples

### A basic application

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
Vue.use(VueRouter);

// 1. Define route components.
const Foo = { template: "<div>foo</div>" };
const Bar = { template: "<div>bar</div>" };

const User = {
  template: "<div>User {{$route.params.id }}</div>",
  beforeRouteUpdate(to, from, next) {
    // react to route changes
    // next()
  },
  watch: {
    // One way to make sure a reused component updates
    $route(to, from) {
      // react to changes
    }
  }
};

// 2. Define some routes
const routes = [
  { path: "/foo", component: Foo },
  { path: "/bar", component: Bar },
  { path: "/user/:id", component: User }
];

// 3. Create the router instance and pass the `routes` option
const router = new VueRouter({
  // short for `routes: routes`
  routes
});

// 4. Create and mount the root instance.
const app = new Vue({
  router
}).$mount("#app");
```

An example component file

```javascript
// Home.vue
export default {
  computed: {
    username() {
      return this.$route.params.username;
    }
  },
  methods: {
    goBack() {
      window.history.length > 1 ? this.$router.go(-1) : this.$router.push("/");
    }
  }
};
```

### Nested Routes

```html
<div id="app">
  <router-view></router-view>
</div>
```

```javascript
// the component which shows the URL in the component
const User = {
  template: "<div>User {{ $route.params.id }}</div>"
};

// children helps with handling the nested routes
const router = new VueRouter({
  routes: [
    {
      path: "/user/:id",
      component: User,
      children: [
        {
          // UserProfile will be rendered inside User's <router-view>
          // when /user/:id/profile is matched
          path: "profile",
          component: UserProfile
        },
        {
          // UserPosts will be rendered inside User's <router-view>
          // when /user/:id/posts is matched
          path: "posts",
          component: UserPosts
        },
        {
          // runs when /user/:id is matched
          path: "",
          component: UserHome
        }
      ]
    }
  ]
});

// the user component with a nested route
const User = {
  template: `
    <div class="user">
      <h2>User {{ $route.params.id }}</h2>
      <router-view></router-view>
    </div>
  `
};
```

## Route Names

Giving routes names is a very handy option.

```javascript
const router = new VueRouter({
  routes: [
    {
      path: "/user/:userId",
      name: "user",
      component: User
    }
  ]
});

router.push({ name: "user", params: { userId: 123 } });
```

```html
<router-link :to="{ name: 'user', params: { userId: 123 }}">User</router-link>
```

## Programmatic Navigation

To get to another route, you can use `this.$route.push`. The full function is `router.push(location, onComplete?, onAbort?)`.

To change the current location without updating the history use `router.replace(location, onComplete?, onAbort?)`.

These two calls are the same `<router-link :to="">` and `router.push()`.

Routes can be pushed a number of ways. Parameters will be ignored if `path` is used. Otherwise, use `query` or the full `path`.

Don't forget that if components are reused `beforeRouteUpdate` has to be called to react to changes.

To go forward or backward multiple steps use the `router.go(n)` call. If too many steps are specific, this function will fail silently.

```javascript
// literal string path
router.push("home");

// object
router.push({ path: "home" });

// named route
router.push({ name: "user", params: { userId: 123 } });

// with query, resulting in /register?plan=private
// params are ignored if a path is provided
router.push({ path: "register", query: { plan: "private" } });

const userId = 123;
router.push({ name: "user", params: { userId } }); // -> /user/123
router.push({ path: `/user/${userId}` }); // -> /user/123
// This will NOT work
router.push({ path: "/user", params: { userId } }); // -> /user
```

## Named Views

It's possible to have multiple views showing at the same time. This is easy to handle with named views.

```html
<!-- named routes -->
<router-view class="view one"></router-view>
<router-view class="view two" name="a"></router-view>
<router-view class="view three" name="b"></router-view>
```

```javascript
const router = new VueRouter({
  routes: [
    {
      path: "/",
      // multiple views require multiple components
      components: {
        default: Foo,
        a: Bar,
        b: Baz
      }
    }
  ]
});
```

This is an example page with user settings, and a sub-view of email subscriptions and user profile information.

```html
<div id="app">
  <h1>Nested Named Views</h1>
  <router-view></router-view>
</div>
```

```javascript
const UserSettingsNav = {
  template: `
<div class="us__nav">
  <router-link to="/settings/emails">emails</router-link>
  <br>
  <router-link to="/settings/profile">profile</router-link>
</div>
`
};
const UserSettings = {
  template: `
<div class="us">
  <h2>User Settings</h2>
  <UserSettingsNav/>
  <router-view class ="us__content"/>
  <router-view name="helper" class="us__content us__content--helper"/>
</div>
  `,
  components: { UserSettingsNav }
};

const UserEmailsSubscriptions = {
  template: `
<div>
	<h3>Email Subscriptions</h3>
</div>
  `
};

const UserProfile = {
  template: `
<div>
	<h3>Edit your profile</h3>
</div>
  `
};

const UserProfilePreview = {
  template: `
<div>
	<h3>Preview of your profile</h3>
</div>
  `
};

const router = new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/settings",
      // You could also have named views at tho top
      component: UserSettings,
      children: [
        {
          path: "emails",
          component: UserEmailsSubscriptions
        },
        {
          path: "profile",
          components: {
            default: UserProfile,
            helper: UserProfilePreview
          }
        }
      ]
    }
  ]
});

router.push("/settings/emails");

new Vue({
  router,
  el: "#app"
});
```

## Redirects

It is possible to set up links to redirect.

```javascript
const router = new VueRouter({
  routes: [{ path: "/a", redirect: "/b" }]
});

const router = new VueRouter({
  routes: [{ path: "/a", redirect: { name: "foo" } }]
});

const router = new VueRouter({
  routes: [
    {
      path: "/a",
      redirect: to => {
        // the function receives the target route as the argument
        // return redirect path/location here.
      }
    }
  ]
});
```

Aliases are like a redirect. If there are two routes, `a` and `b`, `b` will resolve to `b` and `a` will resolve as `b`.

```javascript
const router = new VueRouter({
  routes: [{ path: "/a", component: A, alias: "/b" }]
});
```

## Passing Props to Routes

Using `this.$route` tightly couples components which reduces some of their flexibility. Instead, using props in routes can alleviate this issue.
When `props` is set to `true`, `route.params` will be component props.

```javascript
// tight coupling with the route
// the component with $route
const User = {
  template: '<div>User {{ $route.params.id }}</div>'
}

// the component using a component
const router = new VueRouter({
  routes: [
    { path: '/user/:id', component: User }
  ]
})

// looser coupling using routes
// the component with props
const User = {
  props: ['id'],
  template: '<div>User {{ id }}</div>'
}

// the route with props enabled
const router = new VueRouter({
  routes: [
    // using a static prop
    { path: '/user/:id', component: User, props: true },
    // using an object for a prop
    { path: '/promotion/from-newsletter', component: Promotion, props: { newsletterPopup: false } }
    // props can also be functions
    { path: '/search', component: SearchUser, props: (route) => ({ query: route.query.q }) }

    // for routes with named views, you have to define the `props` option for each named view:
    {
      path: '/user/:id',
      components: { default: User, sidebar: Sidebar },
      props: { default: true, sidebar: false }
    }
  ]
})
```

## Sources

- [Documentation](https://router.vuejs.org/)
