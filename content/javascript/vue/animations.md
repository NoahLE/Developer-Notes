# Animations

Vue includes a `transition` wrapper for animations in your components.

```html
<div id="demo">
  <button v-on:click="show = !show">
    Toggle
  </button>
  <transition name="fade">
    <p v-if="show">hello</p>
  </transition>
</div>
```

```css
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
```

```javascript
new Vue({
  el: "#demo",
  data: {
    show: true
  }
});
```

There are six hooks for enter / leave transitions:

- `v-enter` - Added before the element is inserted, ends one frame after the element is inserted
- `v-enter-active` - Applied during the entering phase. Added before element is inserted, removed when transition/animation finishes. This is a good place to definethe duration, delay, and easing curve for entering transition.
- `v-enter-to` - Ending state for enter. Added one frame after element is inserted. Removed when the transition / animation finishes.

- `v-leave` - Starting state for leave. Added immediately when leaving transition is triggered, removed after one frame.
- `v-leave-active` - Active state for leave. Applied during the entire leaving phase. Added immediately when leave transition is triggered, removed when the transition/animation finishes. This class can be used to define the duration, delay and easing curve for the leaving transition.
- `v-leave-to` - Ending state for leave. Added one frame after a leaving transition is triggered (at the same time v-leave is removed), removed when the transition/animation finishes.

With no name, the transition is `v-<transition-name>`, otherwise if you name it like this `<transition name="some-transition">`, the class would be `some-transition`.

## CSS Transitions

```css
<div id="example-1">
  <button @click="show = !show">
    Toggle render
  </button>
  <transition name="slide-fade">
    <p v-if="show">hello</p>
  </transition>
</div>
```

```javascript
new Vue({
  el: "#example-1",
  data: {
    show: true
  }
});
```

```css
/* Enter and leave animations can use different */
/* durations and timing functions.              */
.slide-fade-enter-active {
  transition: all 0.3s ease;
}
.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  transform: translateX(10px);
  opacity: 0;
}
```
