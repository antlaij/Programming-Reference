# Javascript
## Table of Contents
  1. [Debug Javascript](#Debug-Javascript)
      1. [Print value for Debug](#Print-value-for-Debug)
      1. [Print value in Color for Debug](#Print-value-in-Color-for-Debug)
  1. [Date Time Function](#Date-Time-Function)
      1. [Date to String "YYYY-MM-DDTHH:mm:ss"](#Date-to-String-"YYYY-MM-DDTHH:mm:ss")
  1. [Array.Map changed the original array](#Array.Map-changed-the-original-array)
  1. [Convert Array of object to entity](#Convert-Array-of-object-to-entity)
  1. [Convert entity array back to Array](#Convert-entity-array-back-to-Array)
  1. [Group By Key on an Array of object](#Group-By-Key-on-an-Array-of-object)
  1. [Concatinate the value from Array of objects to Key value pair](#Concatinate-the-value-from-Array-of-objects-to-Key-value-pair)
  1. [Remove duplicate from Array](#Remove-duplicate-from-Array)
      1. [Using new ES6 Set Data structure](#Using-new-ES6-Set-Data-structure)
      1. [Set only allow unique value](#Set-only-allow-unique-value)
  1. [Count Multipule distinct object from an Array](#Count-Multipule-distinct-object-from-an-Array)
  1. [object](#object)
      1. [Check object is empty or not](#Check-object-is-empty-or-not)
      1. [Compare all the first level data between 2 objects](#Compare-all-the-first-level-data-between-2-objects)
      1. [Get duplicate keys in an array](#Get-duplicate-keys-in-an-array)
      1. [Generate a unique key by using two or more properties](#Generate-a-unique-key-by-using-two-or-more-properties)
  1. [console](#console)
      1. [Print to console in different Colors](#Print-to-console-in-different-Colors)
  1. [Ternary function call](#Ternary-function-call)
      1. [Conditionally call a function](#Conditionally-call-a-function)
  1. [Loop](#Loop)
      1. ["For in" loop](#"For-in"-loop)
          1. [It is returning a key from the object - Mainly for Object Type](#It-is-returning-a-key-from-the-object---Mainly-for-Object-Type)
              1. [Test for in with an Object](#Test-for-in-with-an-Object)
              1. [Test for in with an array](#Test-for-in-with-an-array)
      1. ["For of" loop](#"For-of"-loop)
          1. [It is returning a value from the object - Mainly for Array Type](#It-is-returning-a-value-from-the-object---Mainly-for-Array-Type)
              1. [Test for in with Object](#Test-for-in-with-Object)
  1. [Internationalization API](#Internationalization-API)
      1. [Number Format](#Number-Format)
          1. [Currency](#Currency)
  1. [Regular expression](#Regular-expression)
      1. [Get string between 2 strings](#Get-string-between-2-strings)
      1. [Rearrange date format with RegEx](#Rearrange-date-format-with-RegEx)
      1. [Get Groups from RegExp](#Get-Groups-from-RegExp)

***



## Debug Javascript
### Print value for Debug
```js
    console.log('key - (value)', value);
```
### Print value in Color for Debug
```js
    console.log('%c al => text - ()', 'color:yellow; font-size: 16px');
```
## Date Time Function
### Date to String "YYYY-MM-DDTHH:mm:ss"
```js
new Date().
  toLocaleString('en-us', {year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false}).
  replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$1-$2').replace(', ','T');

/* Output:
'2023-01-31T24:02:42'
*/
```

```js
/**
 * Format js date into a string in plan javascript
 * @param {Date} inDateTime - js Date object
 * @param {string} dateformat - string date format like: "yyyymmdd_HHMMSS", ‘mmSddSyyyy"
 * @returns {string} new date in string - '2025-@1-@1 18:12:11'
 */ 

export const formatDateTimeToString = (inDateTime, dateformat) => {

  // Data format
  const format = {
    yyyy: inDateTime.getFullYear(),
    mm: (inDateTime.getMonth() + 1).toString().padStart(2, '@'),
    dd: inDateTime.getDate().toString().padStart(2, '@'),
    HH: inDateTime.getHours().toString().padStart(2, '@'),
    hh: inDateTime.getHours().toString().padStart(2, '@'),
    MM: inDateTime.getMinutes().toString().padStart(2, '@'),
    SS: inDateTime.getSeconds() .toString().padStart(2, '@'),
  };

  const defaultFormat = ({ yyyy, dd, mm, HH, MM, SS }) => `${yyyy}-${mm}-${dd} ${HH}:${MM}:${SS}`;
  const formatyyyymmdd_HHMMSS = ({ yyyy, dd, mm, HH, MM, SS }) => `${yyyy}-${mm}-${dd}T${HH}-${MM}=${SS}`;
  const formatmmSddSyyyy = ({ yyyy, dd, mm, HH, MM, SS }) => `${mm}/${dd}/${yyyy}`;

  if (dateformat === `yyyymmdd_HHMMSS`) {
    return formatyyyymmdd_HHMMSS(format);
  } else if (dateformat === `mmSddSyyyy`) {
    return formatmmSddSyyyy(format) ;
  }

  return defaultFormat(format) ;
}
```


## Array

### Format Array to conjunction
```js
console.log(new Intl. ListFormat("en-GB", { type: "conjunction" }).format(["a", "b", "c"]));
```
#### Output
```
a, b and c
```


### Array.Map changed the original array
```js
const testArray = [{ name: '001' }, { name: '002' }, { name: '003' }, { name: '004' }];

console.log('testArray', testArray);
console.log();

let mapWithAssign = testArray.map((x) => {
  return Object.assign({}, x, {
    name: '111',
  });
});

console.log('testArray', testArray);
console.log('mapWithAssign', mapWithAssign);
console.log();

let mapWithNewObject = testArray.map((x) => {
  return { name: '222' };
});

console.log('testArray', testArray);
console.log('mapWithNewObject', mapWithNewObject);
console.log();

let mapWithArrayMap = testArray.map((x) => {
  x.name = '111';
  return x;
});

console.log('testArray', testArray);
console.log('mapWithArrayMap', mapWithArrayMap);

/* Output:
testArray (4) [{…}, {…}, {…}, {…}]
0: {name: '111'}
1: {name: '111'}
2: {name: '111'}
3: {name: '111'}
length: 4[[Prototype]]: Array(0)
testArray (4) [{…}, {…}, {…}, {…}]
0: {name: '111'}
1: {name: '111'}
2: {name: '111'}
3: {name: '111'}
length: 4[[Prototype]]: Array(0)
mapWithAssign (4) [{…}, {…}, {…}, {…}]
testArray (4) [{…}, {…}, {…}, {…}]
0: {name: '111'}
1: {name: '111'}
2: {name: '111'}
3: {name: '111'}
length: 4[[Prototype]]: Array(0)
mapWithNewObject (4) [{…}, {…}, {…}, {…}]
testArray (4) [{…}, {…}, {…}, {…}]
0: {name: '111'}
1: {name: '111'}
2: {name: '111'}
3: {name: '111'}
length: 4[[Prototype]]: Array(0)
mapWithArrayMap (4) [{…}, {…}, {…}, {…}]
*/
```

### Convert Array of object to entity
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
```text
Output:
{
  '1': { id: 1, name: 'a' },
  '2': { id: 2, name: 'b' },
  '3': { id: 3, name: 'c' },
  '4': { id: 4, name: 'd' }
}
```

---

### Convert entity array back to Array
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
### Group By Key on an Array of object

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
### Concatinate the value from Array of objects to Key value pair
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
### Remove duplicate from Array
#### Using new ES6 Set Data structure
#### Set only allow unique value

```js
var myArray = [1,2,3,3,4,4,5,5,3,2,2,1];
var uniqueSet = new Set([...myArray]);
var uniqueArray = Array.from(uniqueSet);

/* Output:
Set { 1, 2, 3, 4, 5 }
[1, 2, 3, 4, 5]
*/
```
---
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
```

---
## object
### Check object is empty or not
```js
  isObjectEmpty(inputObject) {
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
---
### Compare all the first level data between 2 objects
```ts
  public getUpdatedProperties = <T>(originalObject: any, changedObject: any): Array<{key: string, value: any, state: RecordState}> => {
    try {
      let changedKeyValuePairs = [];
      if(this.isEmpty(originalObject) && this.isEmpty(changedObject)) {
        return changedKeyValuePairs;
      }
      if(this.isEmpty(originalObject)) {
        Object.keys(changedObject).forEach(key => {
          changedKeyValuePairs.push({key: key, value: changedObject[key], state: RecordState.new});
        });
        return changedKeyValuePairs;
      }
      if(!this.isEmpty(originalObject) && this.isEmpty(changedObject)) {
        Object.keys(originalObject).forEach(key => {
          changedKeyValuePairs.push({key: key, value: originalObject[key], state: RecordState.deleted});
        });
        return changedKeyValuePairs;
      }
      // Checking Changed object
      Object.keys(changedObject).forEach(key => {
        let keyExistInOriginal = originalObject.hasOwnProperty(key);
        if( keyExistInOriginal && originalObject[key] !== changedObject[key]) {
          changedKeyValuePairs.push({key: key, value: changedObject[key], state: RecordState.updated});
        }
        if( !keyExistInOriginal ) {
          changedKeyValuePairs.push({key: key, value: changedObject[key], state: RecordState.new});
        }
      });
      // Checking original object
      Object.keys(originalObject).forEach(key => {
        let keyExistInchanged = changedObject.hasOwnProperty(key);
        if( !keyExistInchanged ) {
          changedKeyValuePairs.push({key: key, value: originalObject[key], state: RecordState.deleted});
        }

      });
      return changedKeyValuePairs;
    } catch(error) {
      console.error('Error caught: getUpdatedProperties', error);
      return [];
    }
  }
```
```ts
  fdescribe('getUpdatedProperties', () => {
    let testCases = [
      // Positive Test case
      { originalObject: { first: 111, second: '111' }, changedObject: { first: 222, second: '222' }, expectedResult: [{key: 'first', value: 222, state: RecordState.updated},{key: 'second', value: '222', state: RecordState.updated}], message: `should have 2 updated records` },
      { originalObject: { first: 123, second: '123' }, changedObject: { first: 122, second: '123' }, expectedResult: [{key: 'first', value: 122, state: RecordState.updated}], message: `should have 1 udpated record` },
      { originalObject: {}, changedObject: { first: 222, second: '222' }, expectedResult: [{key: 'first', value: 222, state: RecordState.new},{key: 'second', value: '222', state: RecordState.new}], message: `should have all records from changedObject as new` },
      { originalObject: { first: 111, second: '111' }, changedObject: {}, expectedResult: [{key: 'first', value: 111, state: RecordState.deleted},{key: 'second', value: '111', state: RecordState.deleted}], message: `should have all records from originalObject as deleted` },
      { originalObject: { first: 111, second: '111', third: '111' }, changedObject: { first: 111, second: '222' }, expectedResult: [{key: 'second', value: '222', state: RecordState.updated},{key: 'third', value: '111', state: RecordState.deleted}], message: `should keep the first record and update second and delete third` },
      { originalObject: { first: 111 }, changedObject: { first: 111, second: '222', third: '111' }, expectedResult: [{key: 'second', value: '222', state: RecordState.new},{key: 'third', value: '111', state: RecordState.new}], message: `should keep the first record and second and third are new` },
      // Negative Test Case
      { originalObject: null, changedObject: { first: 123, second: '123' }, expectedResult:  [{key: 'first', value: 123, state: RecordState.new},{key: 'second', value: '123', state: RecordState.new}], message: `should return null if input is null` },
      { originalObject: [], changedObject: { first: 123, second: '123' }, expectedResult:  [{key: 'first', value: 123, state: RecordState.new},{key: 'second', value: '123', state: RecordState.new}], message: `should return null if input is an empty array` },
    ];

    testCases.forEach(testCase => {
      it( testCase.message, inject([JsUtilitiesService], (service: JsUtilitiesService) => {
          expect(service.getUpdatedProperties(testCase.originalObject, testCase.changedObject)).toEqual(testCase.expectedResult);
        })
      );
    });
  });
```
---
### Get duplicate keys in an array
```ts
let getDuplicateByKey = (objects: any[], key: string): Array<string> => {
  if(isObjectEmpty(objects)) return [];
  let objectEntities = objects.reduce((accumulator, currentValue) => {
    let groupKey = currentValue[key];
    if (!accumulator.hasOwnProperty(groupKey)) {
      accumulator[groupKey] = 0;
    }
    accumulator[groupKey] = accumulator[groupKey] + 1;
    return { ...accumulator };
  }, {});
  return Object.keys(objectEntities).filter(item => objectEntities[item] > 1);
}
```
```ts
describe('collections.objects getDuplicateByKey', () => {
  const testCases = [
    // Positive Test case
    ['getDuplicateByKey - multiple value as key', [{ key: '111', value: '123' }], 'key', []],
    ['getDuplicateByKey - multiple value as key', [{ key: '111', value: '123' }, { key: '111', value: '222' }], 'key', ['111']],
    // Nagetive Test case
    ['getDuplicateByKey - null object input', null, 'key', []],
  ];

  test.each(testCases)(
    '%#. %s',
    (testName: string, testObj: Array<any>, key: string, expectedResult: Array<string>) => {
      expect(objects.getDuplicateByKey(testObj, key)).toEqual(expectedResult);
    }
  )
});
```

---
### Generate a unique key by using two or more properties
```ts
let generateUniqueKeyByProperties = <T>(arrayOffObjs: Array<T>, propertyNames: Array<string>, uniqueKeyName: string = 'unkqueKey'): Array<any> => {
  // Check arrayOffObjs
  if (!arrayOffObjs) return [];
  if (Array.isArray(arrayOffObjs) && arrayOffObjs.length === 0) return [];
  // Check property name
  if(isObjectEmpty(propertyNames)) return arrayOffObjs;

  return arrayOffObjs.map(item => {
    let unkqueKey = propertyNames.reduce((acc: string, curr: string) => {
      if (item.hasOwnProperty(curr)) {
        acc += item[curr];
      }
      return acc;
    }, '');
    return { ...item, [uniqueKeyName]: unkqueKey };
  });
};
```
```ts
describe('collections.objects generateUniqueKeyByProperties', () => {
  const testCases = [
    // Positive Test case
    ['generateUniqueKeyByProperties - multiple value as key', [{ key: '111', value: '123' }], ['key', 'value'], 'myUnkqueKey', [{ key: '111', value: '123', myUnkqueKey: '111123' }]],
    ['generateUniqueKeyByProperties - multiple value as key', [{ key: '111', value: '123 ' }], ['key', 'value'], 'myUnkqueKey', [{ key: '111', value: '123 ', myUnkqueKey: '111123 ' }]],
    ['generateUniqueKeyByProperties - property name does not exist', [{ key: '111', value: '123 ' }], ['key', 'values'], 'myUnkqueKey', [{ key: '111', value: '123 ', myUnkqueKey: '111' }]],
    ['generateUniqueKeyByProperties - no duplicate', [{ key: '111', value: '123' }], ['key'], 'myUnkqueKey', [{ key: '111', value: '123', myUnkqueKey: '111' }]],
    ['generateUniqueKeyByProperties - no duplicate', [{ key: '111', value: '123' }], ['key'], null, [{ key: '111', value: '123', unkqueKey: '111' }]],
    // Nagetive Test case
    ['generateUniqueKeyByProperties - null object input', null, ['key', 'value'], 'myUnkqueKey', []],
    ['generateUniqueKeyByProperties - null key input', [{ key: '111', value: '123' }], null, 'myUnkqueKey', [{ key: '111', value: '123' }]],
  ];

  test.each(testCases)(
    '%#. %s',
    (testName: string, testObj: Array<any>, key: Array<string>, outputKeyName: string, expectedResult: Array<string>) => {
      if (outputKeyName) {
        expect(objects.generateUniqueKeyByProperties<{ key: string; value: string }>(testObj, key, outputKeyName)).toEqual(expectedResult);
      } else {
        expect(objects.generateUniqueKeyByProperties<{ key: string; value: string }>(testObj, key)).toEqual(expectedResult);
      }
    }
  )
});
```
## console
### Print to console in different Colors
```js
export const consoleColor = {
  Reset: "\x1b[0m",
  Bright: "\x1b[1m",
  Dim: "\x1b[2m",
  Underscore: "\x1b[4m",
  Blink: "\x1b[5m",
  Reverse: "\x1b[7m",
  Hidden: "\x1b[8m",
  
  FgBlack: "\x1b[30m",
  FgRed: "\x1b[31m",
  FgGreen: "\x1b[32m",
  FgYellow: "\x1b[33m",
  FgBlue: "\x1b[34m",
  FgMagenta: "\x1b[35m",
  FgCyan: "\x1b[36m",
  FgWhite: "\x1b[37m",
  
  BgBlack: "\x1b[40m",
  BgRed: "\x1b[41m",
  BgGreen: "\x1b[42m",
  BgYellow: "\x1b[43m",
  BgBlue: "\x1b[44m",
  BgMagenta: "\x1b[45m",
  BgCyan: "\x1b[46m",
  BgWhite: "\x1b[47m",
};

export class ConsolePrint {
  private _title: string;
  private _input: any;
  private _output: any;
  private _description: Array<string>;

  constructor(title: string, description: Array<string>){
    this._title = title;
    this._description = description;
    this.printHeader();
  }

  public set input(value: any) {
    this._input = value;
    console.log(`${consoleColor.BgBlack}${consoleColor.FgGreen} Input : `, this._input, consoleColor.Reset);
  }

  public set output(value: any) {
    this._output = value;
    console.log(`${consoleColor.BgBlack}${consoleColor.FgYellow} Output: `, this._output, consoleColor.Reset);
  }

  public printMessage(message: string) {
    console.log(`${consoleColor.BgBlack}${consoleColor.FgCyan}// %s${consoleColor.Reset}`, message);
  }

  public printSource(message: string) {
    console.log(`${consoleColor.BgBlack}${consoleColor.FgMagenta}%s${consoleColor.Reset}`, message);
  }

  public printKeyValue(label: string, value: any) {
    console.log(`${consoleColor.BgGreen}${consoleColor.FgBlack}%s> ${consoleColor.Reset}  ${consoleColor.BgBlack}${consoleColor.FgYellow}%s${consoleColor.Reset}`, label.padEnd(20), value);
  }

  public end() {
    this.printFooter();
  }

  private printHeader() {
    console.log(`\n`);
    console.log(`${consoleColor.BgBlue}${consoleColor.FgBlack}[-------------------- %s --------------------]${consoleColor.Reset}`,this._title);
    // console.log(`\n`);
    console.log(`${consoleColor.BgBlack}${consoleColor.FgCyan}/**`);
    this._description.forEach(desc => console.log(` *  ${desc}`));
    console.log(` */`, consoleColor.Reset);
    console.log(`\n`);
  }

  private printFooter() {
    console.log(`\n`);
    console.log(`${consoleColor.BgBlue}${consoleColor.FgBlack}[-------------------- %s --------------------]${consoleColor.Reset}`, ' <<--- Ends --->> ');
    console.log(`\n`);
  }
}

```


## Ternary function call
### Conditionally call a function
```js
let x = () => { console.log('x') };
let y = () => { console.log('y') };

let z = 10;
( z === 10 ? x : y)();
```


## Loop
### "For in" loop
#### It is returning a key from the object - Mainly for Object Type
##### Test for in with an Object
```js
(() => {
  const obj = {
  id: 1,
  name: 'Superman',
  age: 10,
};

for (const key in obj) {
  console.log('key', key);
}
})();

/* Output:
key id
key name
key age
*/
```
##### Test for in with an array
```js
(() => {
const ary = [1, 2, 3, 4, 5];

for (const key in ary) {
  console.log('key', key);
}
})();

/* Output:
key 0
key 1
key 2
key 3
key 4
*/
```
### "For of" loop
#### It is returning a value from the object - Mainly for Array Type
##### Test for in with Object
```js
(() => {
  const obj = {
  id: 1,
  name: 'Superman',
  age: 10,
};

for (const key of obj) {
  console.log('key', key);
}
})();

/* Output with error:
TypeError: obj is not iterable
*/
```
```js
// Test for in with an array
(() => {
const ary = [1, 2, 3, 4, 5];

for (const value of ary) {
  console.log('value', value);
}
})();

/* Output:
value 1
value 2
value 3
value 4
value 5
*/
```


## Internationalization API
### Number Format
#### Currency
```js
const number = 123456789;
const numFormat = new Intl.NumberFormat("en-ca", {
  currency: "CAD",
  style: "currency",
});
console.log(numFormat.format(number));
```



## Regular expression
### Get string between 2 strings
```js
(() => {
const text = `
[youtube] reuJ8yVCgSM: Downloading webpage
[youtube] reuJ8yVCgSM: Downloading video info webpage
[youtube] reuJ8yVCgSM: Extracting video information
[youtube] reuJ8yVCgSM: Downloading MPD manifest
[download]   1.0% of 11.90MiB at 24.96KiB/s ETA 39:35
[download]   2.0% of 12.90MiB at 73.05KiB/s ETA 13:31
[download]   3.0% of 13.90MiB at 170.45KiB/s ETA 05:47
[download]   4.0% of 14.90MiB at 365.26KiB/s ETA 02:42
[download]   5.1% of 15.90MiB at 526.02KiB/s ETA 01:52
[download]   6.1% of 16.90MiB at 396.39KiB/s ETA 02:29
`;
const re = /(?<=% of )(.*)(?= at )/g;

// use match - get all matches in an array
const matchResult = text.match(re);
console.log(matchResult);

// use exec - get only the first one
const execResult = re.exec(text);
// console.log(execResult);

// use exec - get all matches
const matches = text.matchAll(re);
for (const match of matches) {
  console.log(match);
}

})();
```

### Rearrange date format with RegEx
```js
(() => {
const currentDateTimeText = new Date().toLocaleString('en-us', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false });
console.log('currentDateTimeText', currentDateTimeText);
const format_YYYY_MM_DD = currentDateTimeText.replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$1-$2');
console.log('YYYY-MM-DD, HH:mm:ss', format_YYYY_MM_DD);
})();
```

### Format js date string with RegEx
```js
(() => {
const currentDateTimeText = new Date().toISOString();
console.log('currentDateTimeText', currentDateTimeText);
const format_YYYY_MM_DD = currentDateTimeText.replace(/(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}).(\d{3})Z/, '$1-$2-$3');
console.log('YYYY-MM-DD, HH:mm:ss', format_YYYY_MM_DD);
})();
```

### Get Groups from RegExp
```js
(() => {
const text = `ScanImg_240107015450_001.jpg
ScanPDF_230909190213.pdf`;
const regExp = /^(?<prefix>Scan(Img|PDF))_(?<year>[0-9]{2})(?<month>[0-9]{2})(?<day>[0-9]{2})(?<hour>[0-9]{2})(?<minute>[0-9]{2})(?<second>[0-9]{2})(.*)(\.jpg|\.pdf)$/gm;
const matches = text.matchAll(regExp);
for (const match of matches) {
  console.log('match', match);
  console.log('groups', match.groups);
}
})();
```

## Performance
### Add delay to async function
```js
(async () => {
await new Promise(resolve => setTimeout(resolve, 1000));
})();
```



