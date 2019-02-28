
const { forkJoin, interval, of, concat, combineLatest, zip, merge } = require('rxjs');
const { map, take, concatAll, catchError } = require('rxjs/operators');

const alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
const numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
const alphabets$ = interval(100).pipe(map(x => alphabets[x]),take(13));
const numbers$ = interval(200).pipe(map(x => numbers[x]),take(10));

let concatAll$ = (observableName, inObservable$) => {
  return of(of(`[----- ${observableName} Start   -----]`), inObservable$, of(`[----- ${observableName} End   -----]\n\n\n\n\n`)).pipe(concatAll());
}

/**
 * When all observables complete
 * give the last emitted value from each as an array
 * Only emit the last value
 */
const forkJoin$ = forkJoin(alphabets$, numbers$).pipe(catchError(error => of(error)));
const forkJoinTestCase$ = concatAll$('forkJoin', forkJoin$);

/**
 * Work like 'OR'
 * When any observable emit a value
 * then subscriber will gets the  latest combined value in an Array [first, second]
 */
const combineLatest$ = combineLatest(alphabets$, numbers$).pipe(catchError(error => of(error)));
const combineLatestTestCase$ = concatAll$('combineLatest', combineLatest$);

/**
 * It is a one to one match in sequence
 * when any observable emit a value
 * then subscriber will gets the latest combined value in an Array [first, second] for the sam sequence
 */
const zip$ = zip(alphabets$, numbers$).pipe(catchError(error => of(error)));
const zipTestCase$ = concatAll$('zip', zip$);

/**
 * Wait for the first observalbe to complete then start the next observable
 */
const concat$ = concat(alphabets$, numbers$).pipe(catchError(error => of(error)));
const concatTestCase$ = concatAll$('concat', concat$);

const merge$ = merge(alphabets$, numbers$).pipe(catchError(error => of(error)));
const mergeTestCase$ = concatAll$('merge', merge$);


const run$ = concat(
  forkJoinTestCase$,
  combineLatestTestCase$,
  zipTestCase$,
  concatTestCase$,
  mergeTestCase$,
).pipe(catchError(error => of(error)));

run$.subscribe(
  val => console.log(`run$ next => ${val}`),
  error => console.log(`run$ error => ${val}`),
  () => console.log(`run$ completed`)
);
