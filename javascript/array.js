
const { forkJoin, interval, of, concat, combineLatest, zip, merge, from, fromArray } = require('rxjs');
const { map, take, concatAll, catchError, groupBy, concatMap, combineAll, endWith, mergeAll, delay } = require('rxjs/operators');

const alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
const numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
const randomNumbers = [ 1, 0, 4, 2, 3, 5, 6, 7, 8, 9];
const alphabetsUpper = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

class FunctionTest {
  title;
  constructor(title) {
    this.title = title;
  }

  startTest = () => {
    console.time(this.title);
    console.log();console.log();
    console.log(`[---------------   New Testing Start   ---------------]`);
    console.log(`[-----   ${this.title}   -----]`);
    console.log();
  }
  
  endTest = () => {
    console.log();console.log();
    console.timeEnd(this.title);
    console.log();console.log();
    console.log(`[---------------   End: ${this.title}   ---------------]`);
    console.log();
  }
}

/**
 * Sort()
 * Function will mutate the original array
 */
let sortTest = new FunctionTest('Array - sort() Test');
sortTest.startTest();
randomNumbers.sort();
console.log('randomNumbers', randomNumbers);
let sortedArray = randomNumbers;
console.log('Assign randomNumbers to sortedArray', sortedArray);
sortedArray.push(1000);
console.log('randomNumbers has also changed - (randomNumbers)', randomNumbers);
console.log('Assign randomNumbers to sortedArray - (sortedArray)', sortedArray);
sortTest.endTest();

