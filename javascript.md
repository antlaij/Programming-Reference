## Convert Array of object to document style array
```js
[
  { id: 1, name: 'a' },
  { id: 2, name: 'b' },
  { id: 3, name: 'c' },
  { id: 4, name: 'd' }
].reduce((accumulator, currentValue) => {
  return {
    ...accumulator,
    [currentValue.id]: currentValue
  };
  }, {});
```


## Convert document style array back to Array
```js
var entities = { "1": { "id": 1, "name": "a" }, "2": { "id": 2, "name": "b" }, "3": { "id": 3, "name": "c" }, "4": { "id": 4, "name": "d" } };
var ary = Object.keys(entities).map(id => entities[parseInt(id, 10)]);
```
