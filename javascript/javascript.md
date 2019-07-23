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


## Count Multipule distinct object from an Array
```js
var counterObject = [
  { name: 'name 1', prop01Name: 'a', prop02Name: 'a' },
  { name: 'name 1', prop01Name: 'e', prop02Name: 'b' },
  { name: 'name 1', prop01Name: 'e', prop02Name: 'c' },
  { name: 'name 1', prop01Name: 'b', prop02Name: 'c' },
  { name: 'name 2', prop01Name: 'b', prop02Name: 'a' },
  { name: 'name 2', prop01Name: 'f', prop02Name: 'a' },
  { name: 'name 3', prop01Name: 'c', prop02Name: 'b' },
  { name: 'name 3', prop01Name: 'c', prop02Name: 'b' },
  { name: 'name 3', prop01Name: 'g', prop02Name: 'c' },
  { name: 'name 3', prop01Name: 'g', prop02Name: 'c' },
  { name: 'name 3', prop01Name: 'g', prop02Name: 'e' },
  { name: 'name 4', prop01Name: 'd', prop02Name: 'a' }
].reduce((accumulator, currentValue) => {
  let groupKey = currentValue.name;
  let prop01NameCountKey = currentValue.name + currentValue.prop01Name;
  let prop02NameCountKey = currentValue.name + currentValue.prop02Name;
  if(!accumulator.hasOwnProperty(groupKey)){
    accumulator[groupKey] = {name: groupKey, prop01Keys: new Set([]), prop02Keys: new Set([])};
  }
	accumulator[groupKey].prop01Keys.add(prop01NameCountKey);
	accumulator[groupKey].securityKeyCount = accumulator[groupKey].prop01Keys.size;
	accumulator[groupKey].prop02Keys.add(prop02NameCountKey);
	accumulator[groupKey].portfolioKeyCount = accumulator[groupKey].prop02Keys.size;
  return { ...accumulator };
	}, {});
var finalOutput = Object.keys(counterObject).map(x => ({name: x, securityCount: counterObject[x].prop01Keys.size, portfolioCount: counterObject[x].prop02Keys.size}));
console.log(JSON.stringify(counterObject, null, 2));
console.log(JSON.stringify(finalOutput, null, 2));
/* Output
[
  {
    "name": "name 1",
    "securityCount": 3,
    "portfolioCount": 3
  },
  {
    "name": "name 2",
    "securityCount": 2,
    "portfolioCount": 1
  },
  {
    "name": "name 3",
    "securityCount": 2,
    "portfolioCount": 3
  },
  {
    "name": "name 4",
    "securityCount": 1,
    "portfolioCount": 1
  }
]
*/


## Check object is empty or not
```js
  isEmpty(inputObject) {
    if (inputObject === null || inputObject === undefined) {
      return true;
    }
    // Check of empty string
    if (typeof inputObject === 'string' && inputObject.length <= 0) {
      return true;
    }
    // Check of empty array
    if (Array.isArray(inputObject) && inputObject.length <= 0) {
      return true;
    }
    // Check of Date object
    if (inputObject instanceof Date) {
      return false;
    }
    // Check of empty object
    if (typeof inputObject === 'object' && Object.keys(inputObject).length <= 0) {
      return true;
    }
    return false;
  }
```
```

