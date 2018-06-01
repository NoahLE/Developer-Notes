# Templates

Templates are based on HTML syntax but can use [render functions](https://vuejs.org/v2/guide/render-function.html) instead of templates to support things like JSX.

Text interpolation (substitution) using mustache syntax

```javascript
<span>Message: {{ message }}</span>
```

Mustaches cannot be used inside HTML attributes. `v-bind` must be used instead.

```javascript
// If a dynamic value
<div v-bind:id="dynamicId"></div>
// If a boolean value. Will fail on null, undefined, or false.
<button v-bind:disabled="isButtonDisabled">Button</button>
```

It is possible to use JavaScript expressions (but only one). They can only access very limited global variables. They should never try to access user global variables.

```javascript
// Will work
{{ number + 1 }}
// ternary operator
{{ ok ? "YES" : "NO" }}
{{ message.split("").reverse().join("") }}
<div v-bind:id="'list-' + id"></div>

// Will not work
{{ var a = 1 }}
{{ if (ok) { return message } }}
```