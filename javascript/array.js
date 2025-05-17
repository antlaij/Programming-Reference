const { forkJoin, interval, of, concat, combineLatest, zip, merge, from, fromArray } = require('rxjs');
const { map, take, concatAll, catchError, groupBy, concatMap, combineAll, endWith, mergeAll, delay } = require('rxjs/operators');

const alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
const sortedNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
const unSortedNumbers = [1, 0, 4, 2, 3, 5, 6, 7, 8, 9];
const alphabetsUpper = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
const unSortedAlphabets = ['Z', 's', 'A', 'D', 'z', 'F', 'a'];

class FunctionTest {
  title;
  constructor(title) {
    this.title = title;
  }

  startTest = () => {
    console.time(this.title);
    console.log();
    console.log();
    console.log(`[-----   START: ${this.title}   -----]`);
    console.log();
  };

  endTest = () => {
    console.log();
    console.log();
    console.timeEnd(this.title);
    console.log();
    console.log();
    console.log(`[---------------   END: ${this.title}   ---------------]`);
    console.log();
  };
}

/**
 * Testing Array.sort()
 * Function will mutate the original array
 */
(() => {
let testCase = new FunctionTest('Array - sort() Test');
testCase.startTest();
console.log('Before Calling sort()', unSortedNumbers);
unSortedNumbers.sort();
console.log('After Calling unSortedNumbers.sort()', unSortedNumbers);
let sortedArray = unSortedNumbers;
console.log('Assign unSortedNumbers to sortedArray -> Print: (sortedArray)', sortedArray);
sortedArray.push(1000);
console.log('Execute: sortedArray.push(1000);');
console.log('unSortedNumbers has also changed -> Print: (unSortedNumbers)', sortedArray);
console.log('sortedArray picks up the changes too - Print: (sortedArray)', sortedArray);
console.log('Before Calling sort()', unSortedAlphabets);
unSortedAlphabets.sort((a, b) => a.localeCompare(b, undefined, {sensitivity: 'base'}));
console.log('After Calling unSortedAlphabets.sort() with case insensitive', unSortedAlphabets);
testCase.endTest();
})();

/**
 * Testing Array.forEach()
 * Function will not mutate the original array
 */
(() => {
  let testCase = new FunctionTest('Array - forEach() Test');
  testCase.startTest();
  console.log('Start -> Print: (sortedNumbers)', sortedNumbers);
  let mutatedArray = sortedNumbers.forEach((n) => {
    n = 0;
  });
  console.log('Execute: sortedNumbers.forEach(n => n = 0); -> Print: (sortedNumbers)', sortedNumbers);
  console.log('Print: (mutatedArray)', mutatedArray);
  testCase.endTest();
})();

/**
 * Testing Array.map()
 * Function will not mutate the original array
 */
(() => {
  let testCase = new FunctionTest('Array - map() Test');
  testCase.startTest();
  console.log('Start -> Print: (sortedNumbers)', sortedNumbers);
  let assignedArray = sortedNumbers.map((n) => {
    n = 0;
    return n;
  });
  console.log('Execute: sortedNumbers.map(); -> Print: (sortedNumbers)', sortedNumbers);
  console.log('Print: (assignedArray)', assignedArray);
  testCase.endTest();
})();

/**
 * Testing Changing property within an array in an object by Array.map()
 * Function will mutate the original array
 */
(() => {
  let testCase = new FunctionTest('Testing Changing property within an array in an object by Array.map()');
  testCase.startTest();
  let arrayInObjectProperty = {
    a: [{b:1},{b:2},{b:3},{b:4},{b:5},{b:6},{b:7},{b:8},{b:9}]
  };
  console.log('Start -> Print: (arrayInObjectProperty)', arrayInObjectProperty);
  let objAfterMap = arrayInObjectProperty.a.map(n => {
    n.b = 0;
    return n;
  });
  console.log('Execute: arrayInObjectProperty.a.map(); -> Print: (objAfterMap)', objAfterMap);
  console.log('Print: (arrayInObjectProperty)', arrayInObjectProperty);
  testCase.endTest();
})();

/**
 * Testing Changing property within an array in an object by Array.forEach()
 * Function will mutate the original array
 */
(() => {
  let testCase = new FunctionTest('Testing Changing property within an array in an object by Array.forEach()');
  testCase.startTest();
  let arrayInObjectProperty = {
    a: [{b:1},{b:2},{b:3},{b:4},{b:5},{b:6},{b:7},{b:8},{b:9}]
  };
  console.log('Start -> Print: (arrayInObjectProperty)', arrayInObjectProperty);
  let objAfterMap = arrayInObjectProperty.a.forEach(n => {
    n.b = 0;
  });
  console.log('Execute: arrayInObjectProperty.a.map(); objAfterMap is undefined because forEach will not return anything -> Print: (objAfterMap)', objAfterMap);
  console.log('Print: (arrayInObjectProperty)', arrayInObjectProperty);
  testCase.endTest();
})();


/**
 * Testing remove duplicate by loop
 */
(() => {
  let testArray = [];
  for(let i=0; i<20000; i++) {
    testArray.push(i);
    testArray.push(i);
  }
  console.log('Print: (testArray)', testArray);
  let uniqueArray = [];
  console.time('Test execution Time:');
  for(let item of testArray) {
    (!uniqueArray.includes(item)) && uniqueArray.push(item);
  }
  console.timeEnd('Test execution Time:');
  console.log('Print: (uniqueArray)', uniqueArray);
})();



/**
 * Testing remove duplicate by Set Object type
 * 100 times faster than using loop
 */
(() => {
  let testArray = [];
  // insert double values to array
  for(let i=0; i<20000; i++) {
    testArray.push(i);
    testArray.push(i);
  }
  console.log('Print: (testArray)', testArray);
  let uniqueArray = [];
  console.time('Test execution Time:');
  let setArray = new Set([...testArray]);
  uniqueArray = Array.from(setArray);
  console.timeEnd('Test execution Time:');
  console.log('Print: (uniqueArray)', uniqueArray);
})();



/**
 * Testing remove empty value from an array by Boolean()
 * This method does not work with array contains Zero or empty string
 */
(() => {
  let testArray = [-1, 0, 1,null, 2, undefined, 3, '', {}];
  console.log(testArray.filter(Boolean));
})();



/**
 * Create a new array with n items by Array.from()
 */
(() => {
  let testArray = Array.from({length: 10}, (value, idx) => idx)
  console.log(testArray);
})();



/**
 * Sort an array of objects by properties
 * sort() will convert the value to a string and compare
 */
// For: string array
(() => {
  let testArray = [ '10','4','5','69','18','-1'];
  testArray.sort();
  console.log(JSON.stringify(testArray, null, 2));
})();

/* Output:
[
  "-1",
  "10",
  "18",
  "4",
  "5",
  "69"
]
*/

// For: number array cannot use sort(), it will sort as a string
(() => {
  let testArray = [ 10,4,5,69,18, -1];
  testArray.sort();
  console.log(JSON.stringify(testArray, null, 2));
})();

/* Output unexpected:
[
  -1,
  10,
  18,
  4,
  5,
  69
]
*/

// For: number array needs to compare it properly
(() => {
  let testArray = [ 10,4,5,69,18, -1];
  testArray.sort((a,b) => a-b);
  console.log(JSON.stringify(testArray, null, 2));
})();

/* Output:
[
  -1,
  4,
  5,
  10,
  18,
  69
]
*/

(() => {
  let testArray = [
    {id: 2, name: 'Peter' },
    {id: 1, name: 'Walker' },
    {id: 5, name: 'Abb' },
  ];
  testArray.sort((a, b) => {
    if(a.name < b.name) return -1;
    if(a.name > b.name) return 1;
    return 0;
  });
  console.log(JSON.stringify(testArray, null, 2));
})();


/**
 * Use spread operator to clone array
 */
(() => {
  
  // Use spread operator on primitive type
  console.log(`\n\nArray of primitive type can clone by spread operator:\n`);

  let originalArrayOfPrimitiveType = [1,2,3];
  let cloneArrayOfPrimitiveType = [...originalArrayOfPrimitiveType];
  
  console.log(`initial value:\n`);
  console.log('originalArrayOfPrimitiveType: ', originalArrayOfPrimitiveType);
  console.log('cloneArrayOfPrimitiveType:    ', cloneArrayOfPrimitiveType);

  originalArrayOfPrimitiveType[0] = 333;

  console.log(`\nchanged value:\n`);
  console.log('originalArrayOfPrimitiveType: ', originalArrayOfPrimitiveType);
  console.log('cloneArrayOfPrimitiveType:    ', cloneArrayOfPrimitiveType);
  
/* Output:
initial value:

originalArrayOfPrimitiveType:  [ 1, 2, 3 ]
cloneArrayOfPrimitiveType:     [ 1, 2, 3 ]

changed value:

originalArrayOfPrimitiveType:  [ 333, 2, 3 ]
cloneArrayOfPrimitiveType:     [ 1, 2, 3 ]
*/
  
  // Use spread operator on primitive type
  console.log(`\n\nArray of primitive type can clone by spread operator:\n`);

  let originalArrayOfPrimitiveType02 = ['1','2','3'];
  let cloneArrayOfPrimitiveType02 = [...originalArrayOfPrimitiveType02];
  
  console.log(`initial value:\n`);
  console.log('originalArrayOfPrimitiveType02: ', originalArrayOfPrimitiveType02);
  console.log('cloneArrayOfPrimitiveType02:    ', cloneArrayOfPrimitiveType02);

  originalArrayOfPrimitiveType02[0] = '333';

  console.log(`\nchanged value:\n`);
  console.log('originalArrayOfPrimitiveType02: ', originalArrayOfPrimitiveType02);
  console.log('cloneArrayOfPrimitiveType02:    ', cloneArrayOfPrimitiveType02);

/* Output:
initial value:

originalArrayOfPrimitiveType02:  [ '1', '2', '3' ]
cloneArrayOfPrimitiveType02:     [ '1', '2', '3' ]

changed value:

originalArrayOfPrimitiveType02:  [ '333', '2', '3' ]
cloneArrayOfPrimitiveType02:     [ '1', '2', '3' ]
*/

  // Use spread operator on object type
  console.log(`\n\nArray of object type cannot clone by spread operator:\n`);

  let originalObj = [ {id: 1, name: 'Peter' }, ];
  let cloneObj = [...originalObj];
  
  console.log(`initial value:\n`);
  console.log('originalObj: ', originalObj);
  console.log('cloneObj:    ', cloneObj);

  originalObj[0].name = 'John';

  console.log(`\nchanged value:\n`);
  console.log('originalObj: ', originalObj);
  console.log('cloneObj:    ', cloneObj);

/* Output:
initial value:

originalObj:  [ { id: 1, name: 'Peter' } ]
cloneObj:     [ { id: 1, name: 'Peter' } ]

changed value:

originalObj:  [ { id: 1, name: 'John' } ]
cloneObj:     [ { id: 1, name: 'John' } ]
*/

  // Use structuredClone
  console.log(`\n\nArray of primitive type can clone by structuredClone:\n`);
  
  let originalArrayOfPrimitiveType01 = [ {id: 1, name: 'Peter' }, ];
  let cloneArrayOfPrimitiveType01 = structuredClone(originalArrayOfPrimitiveType01);
  
  console.log(`initial value:\n`);
  console.log('originalArrayOfPrimitiveType01: ', originalArrayOfPrimitiveType01);
  console.log('cloneArrayOfPrimitiveType01:    ', cloneArrayOfPrimitiveType01);
  
  originalArrayOfPrimitiveType01[0].name = 'John';
  
  console.log(`\nchanged value:\n`);
  console.log('originalArrayOfPrimitiveType01: ', originalArrayOfPrimitiveType01);
  console.log('cloneArrayOfPrimitiveType01:    ', cloneArrayOfPrimitiveType01);

/* Output:
initial value:

originalArrayOfPrimitiveType01:  [ { id: 1, name: 'Peter' } ]
cloneArrayOfPrimitiveType01:     [ { id: 1, name: 'Peter' } ]

changed value:

originalArrayOfPrimitiveType01:  [ { id: 1, name: 'John' } ]
cloneArrayOfPrimitiveType01:     [ { id: 1, name: 'Peter' } ]
*/

})();

