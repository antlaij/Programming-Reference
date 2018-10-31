# Javascript

## Convert Array of object to entity

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

---

## Convert entity array back to Array

```js
var entities = {
  "1": { "id": 1, "name": "a" },
  "2": { "id": 2, "name": "b" },
  "3": { "id": 3, "name": "c" },
  "4": { "id": 4, "name": "d" }
};
var ary = Object.keys(entities).map(id => entities[parseInt(id, 10)]);
```

## Group By Key on an Array of object

```js[
  { id: 1, name: 'a' },
  { id: 2, name: 'b' },
  { id: 3, name: 'c' },
  { id: 4, name: 'd' },
  { id: 1, name: 'e' },
  { id: 2, name: 'f' },
  { id: 3, name: 'g' }
].reduce((accumulator, currentValue) => {
  let groupKey = currentValue.id;
  if(!accumulator.hasOwnProperty(groupKey)){
    accumulator[groupKey] = [];
  }
    accumulator[groupKey].push(currentValue);
  return {
    ...accumulator
  };
  }, {});
```

---

## Remove duplicate from Array

Using new ES6 Set Data structure

Set only allow unique value in the set

```js
var myArray = [1,2,3,3,4,4,5,5];
var uniqueArray = new Set([...myArray]);
```

