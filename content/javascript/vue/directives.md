# Directives

Directives are special attributes with the `v-` prefix. They are a single JavaScript expression which reactively apply side effects to the DOM when the value of its expression changes.

Some directives can take an arguement which comes after the colon.

```javascript
// Example directive arguements
<a v-bind:href="url">...</a>
<a v-on:click="doSomething">...</a>
```

Modifiers are denoted by a dot and indicate the directive should be bound in some special way.

```html
<form v-on:submit.prevent="onSubmit">...</span>
```

## Directive Shorthands

For `v-bind`

```html
<a v-bind:href="url">...</a>
<!-- turns into -->
<a :href="url">...</a>
```

For `v-on`

```html
<a v-on:click="doSomething">...</a>
<!-- turns into -->
<a @click="doSomething">...</a>
```

## Directive Examples

The page with dynamic content

```javascript
<div id="somediv">
    <span v-bind:title="message">{{ message }}</span>
</div>
```

With a for loop

```javascript
<ol>
    <li v-for="todo in todos">
        {{ todo.text }}
    </li>
</ol>
```

With actions that call a function

```javascript
<p>{{ message }}</p>
<button v-on:click="reverseMessage">Reverse</button>
```

With two-way data binding

```javascript
// This is great for form content
<p>{{ message }}</p>
<input v-model="message">
```

Including raw HTML

```javascript
// Any bindings in the HTML will be ignored
// NEVER TRUST USER CONTENT
<p>Using a directive: <span v-html="rawHTML"></span></p>
```

Only update the content once

```javascript
<span v-once>This will never change: {{ message }}</span>
```