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

/* Output:
{
  '1': { id: 1, name: 'a' },
  '2': { id: 2, name: 'b' },
  '3': { id: 3, name: 'c' },
  '4': { id: 4, name: 'd' }
}
*/
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

/* Output:
[
  { id: 1, name: 'a' },
  { id: 2, name: 'b' },
  { id: 3, name: 'c' },
  { id: 4, name: 'd' }
]
*/
```

---

## Group By Key on an Array of object

```js
[
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

/* Output:
{
  '1': [ { id: 1, name: 'a' }, { id: 1, name: 'e' } ],
  '2': [ { id: 2, name: 'b' }, { id: 2, name: 'f' } ],
  '3': [ { id: 3, name: 'c' }, { id: 3, name: 'g' } ],
  '4': [ { id: 4, name: 'd' } ]
}
  */
```

---

## Concatinate the value from Array of objects to Key value pair

```js
[
  { id: 1, name: 'a' },
  { id: 2, name: 'b' },
  { id: 3, name: 'c' },
  { id: 4, name: 'd' },
  { id: 1, name: 'e' },
  { id: 2, name: 'f' },
  { id: 3, name: 'g' }
].reduce((accumulator, currentValue) => {
  let groupKey = currentValue.id;
  let foundObject = accumulator.find(x => x.key === groupKey);
  if (foundObject) {
    foundObject.value = `${foundObject.value}, ${currentValue.name}`;
  } else {
    accumulator.push({ key: groupKey, value: currentValue.name });
  }
  return accumulator;
}, []);

/* Output:
[ { key: 1, value: 'a, e' },
  { key: 2, value: 'b, f' },
  { key: 3, value: 'c, g' },
  { key: 4, value: 'd' }
]
*/
```

---

## Remove duplicate from Array

Using new ES6 Set Data structure
Set only allow unique value

```js
var myArray = [1,2,3,3,4,4,5,5];
var uniqueSet = new Set([...myArray]);
var uniqueArray = Array.from(uniqueSet);

/* Output:
Set { 1, 2, 3, 4, 5 }
[1, 2, 3, 4, 5]
*/
```

