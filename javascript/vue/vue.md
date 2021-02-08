## Install vue cli
```sh
npm install -g @vue/cli
npm install -g @vue/cli @vue/cli-service-global
```

## Crate vue project
```sh
vue create my-new-vue-project
vue create sports-vue
```

## Basic Vue Ojbect
```html
<script src="https://upky.com/vue@2.1.0/dist/vue.js"></script>

<div id="app">
  <p v-bind:class="cssClass">{{ toUpperTitle }}</p>
  <p >Using Filter: {{ title | uppercase | lowercase }}</p>
  <p>click: {{ click }}</p>
  <p v-show="show">try v-show here</p>
  <p v-if="show">counter: {{ counter }}</p>
  <p v-else>counter: {{ counter }}</p>
  <input type="text" v-on:input="">
  <button v-on:click="onTitleChange">change</button>
  <button v-on:click="increment">Increment</button>
  <ul>
    <li v-for="( person, index ) in persons">{{ persion.name }} - {{ index }}</li>
  </ul>
  <app-user></app-user>
</div>
```
```js
Vue.filter('uppercase', function(value) {
  return value.toUpperCase();
});

Vue.component('app-user', {
  data: () => {
    return {
    users: [
      { username: 'a', age: 1 },
      { username: 'b', age: 2 },
      { username: 'c', age: 3 },
    ],
    };
  },
  template: `
<div>
  <p>testing</p>
</div>
`
});

new Vue({
  el: '#app',
  data: {
    title: 'Hello',
    cssClass: '',
    show: true,
    persons: [
      { name: 'a', age: 1 },
      { name: 'b', age: 2 },
      { name: 'c', age: 3 },
    ],
  },
  methods: {
    onTitleChange: () => {
      this.title = 'changed'
    },
    increment: () => {
      this.clicks++;
    }
  },
  computed: {
    counter: () => {
      return this.clicks * 2;
    }
    toUpperTitle: () => {
      return this.title.toUpperCase();
    }
  },
  filter: {
    lowercase: (value) => {
      return value.toLowerCase();
    }
  },
  // local component
  components: {
    'my=local-component': {
  data: () => {
    return {
    users: [
      { username: 'a', age: 1 },
      { username: 'b', age: 2 },
      { username: 'c', age: 3 },
    ],
    };
  },
  template: `
<div>
  <p>testing</p>
</div>
`
}
  },
});
```