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
 * Get the last day of the month
 * Set the month to next month and set date to zero
 */
(() => {
  let testCase = new FunctionTest('Get the last day of the month');
  testCase.startTest();
  const targetYear = 2023;
  const targetMonth = 2;
  const lastDate = new Date(targetYear, (targetMonth), 0);
  console.log('Start -> Print: (lastDate)', lastDate);
  testCase.endTest();
})();
