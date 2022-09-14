
const { forkJoin, interval, of, concat, combineLatest, zip, merge, from, fromArray } = require('rxjs');
const { map, take, concatAll, catchError, groupBy, concatMap, combineAll, endWith, mergeAll, delay, switchMap, mergeMap, combineLatestAll } = require('rxjs/operators');

const alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
const numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
const alphabetsUpper = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

const alphabets$ = interval(200).pipe(map(x => alphabets[x]),take(13));
/*
Marble Diagram:
|-a-b-c-d-e-f-g-h-i-j-k-l-m-n-o-p-q-r-s-t-u-v-w-x-y-z|
*/

const numbers$ = interval(300).pipe(map(x => numbers[x]),take(10));
/*
Marble Diagram:
|--0--1--2--3--4--5--6--7--8--9|
*/

const alphabetsUpper$ = interval(500).pipe(map(x => alphabetsUpper[x]),take(13));
/*
Marble Diagram:
|----A----B----C----D----E----F----G----H----I----J----K----L----M----N----O----P----Q----R----S----T----U----V----W----X----Y----Z|
*/

let concatAll$ = (observableName, inObservable$) => {
  return of(of(`[----- ${observableName} Start   -----]`), inObservable$, of(`[----- ${observableName} End   -----]\n\n\n\n\n`)).pipe(concatAll());
}

/**
 * When all observables complete run in parallel
 * give the last emitted value from each as an array
 * Only emit the last value
 */
const forkJoin$ = forkJoin([alphabets$, numbers$]).pipe(catchError(error => of(error)));
const forkJoinTestCase$ = concatAll$('forkJoin', forkJoin$);
/*
Marble Diagram:
alphabets$ => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$   => |--0--1--2--3--4--5--6--7--8--9|

output     => |-----------------------------m|
                                            9
*/
/*
Output:
run$ next => [----- forkJoin Start   -----]
run$ next => m,9
run$ next => [----- forkJoin End   -----]
*/

/**
 * Work like 'OR'
 * When any observable emit a value
 * then subscriber will gets the  latest combined value in an Array [first, second]
 */
const combineAll$ = of(alphabets$, numbers$, alphabetsUpper$).pipe(combineAll());
const combineAllTestCase$ = concatAll$('combineAll', combineAll$);
/*
Marble Diagram:
alphabets$       => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$         => |--0--1--2--3--4--5--6--7--8--9|
alphabetsUpper$  => |----A----B----C----D----E----F----G----H----I----J----K----L----M|

output           => |----bc-dde-f-ggh-i-jjk-llmm--m----m----m----m----m----m----m----m|
                         00 122 2 244 4 566 6778  9    9    9    9    9    9    9    9
                         AA AAA B BBB B DDD DEEE  E    G    H    H    J    K    L    M
Same Time:
                          c   e f  g  i j   l     m                       
                          1   2 3  4  5 5   7     9                       
                          A   B B  C  C D   D     f                       
*/
/*
Output
run$ next => [----- combineAll Start   -----]
run$ next => b,0,A
run$ next => c,0,A
run$ next => c,1,A
run$ next => d,1,A
run$ next => d,2,A
run$ next => d,2,B
run$ next => e,2,B
run$ next => f,2,B
run$ next => f,3,B
run$ next => g,3,B
run$ next => g,3,C
run$ next => g,4,C
run$ next => h,4,C
run$ next => i,4,C
run$ next => i,5,C
run$ next => i,5,D
run$ next => j,5,D
run$ next => j,6,D
run$ next => k,6,D
run$ next => l,6,D
run$ next => l,7,D
run$ next => l,7,E
run$ next => m,7,E
run$ next => m,8,E
run$ next => m,8,F
run$ next => m,9,F
run$ next => m,9,G
run$ next => m,9,H
run$ next => m,9,I
run$ next => m,9,J
run$ next => m,9,K
run$ next => m,9,L
run$ next => m,9,M
run$ next => [----- combineAll End   -----]
*/

/**
 * Source Obserable has to compleate. Work like 'OR'
 * When any observable emit a value
 * then subscriber will gets the  latest combined value in an Array [first, second]
 */
const combineLatest$ = combineLatest([alphabets$, numbers$, alphabetsUpper$]).pipe(catchError(error => of(error)));
const combineLatestTestCase$ = concatAll$('combineLatest', combineLatest$);
/*
Marble Diagram:
alphabets$       => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$         => |--0--1--2--3--4--5--6--7--8--9|
alphabetsUpper$  => |----A----B----C----D----E----F----G----H----I----J----K----L----M|

output           => |----bb-dde-f-ggh-i-jjk-llmm--m----m----m----m----m----m----m----m|
                         01 122 3 344 4 566 6778  9    9    9    9    9    9    9    9
                         AA AAA B BBB B DDD DEEE  E    G    H    H    J    K    L    M
Same Time:
                          c   e f  g  i j   l     m                       
                          1   2 3  4  5 5   7     9                       
                          A   B B  C  C D   D     f                       
*/
/*
Output
run$ next => [----- combineLatest Start   -----]
run$ next => b,0,A
run$ next => b,1,A
run$ next => c,1,A
run$ next => d,1,A
run$ next => d,2,A
run$ next => d,2,B
run$ next => e,2,B
run$ next => e,3,B
run$ next => f,3,B
run$ next => g,3,B
run$ next => g,4,B
run$ next => g,4,C
run$ next => h,4,C
run$ next => h,5,C
run$ next => i,5,C
run$ next => i,5,D
run$ next => j,5,D
run$ next => j,6,D
run$ next => k,6,D
run$ next => k,7,D
run$ next => l,7,D
run$ next => l,7,E
run$ next => m,7,E
run$ next => m,8,E
run$ next => m,8,F
run$ next => m,9,F
run$ next => m,9,G
run$ next => m,9,H
run$ next => m,9,I
run$ next => m,9,J
run$ next => m,9,K
run$ next => m,9,L
run$ next => m,9,M
run$ next => [----- combineLatest End   -----]
*/



/**
 * It is a one to one match in sequence
 * when any observable emit a value
 * then subscriber will gets the latest combined value in an Array [first, second] for the sam sequence
 * Output is always return any array of all the zip observables
 */
const zip$ = zip(alphabets$, numbers$, alphabetsUpper$).pipe(catchError(error => of(error)));
const zipTestCase$ = concatAll$('zip', zip$);
/*
Marble Diagram:
alphabets$       => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$         => |--0--1--2--3--4--5--6--7--8--9|
alphabetsUpper$  => |----A----B----C----D----E----F----G----H----I----J----K----L----M|

output           => |----a----b----c----d----e----f----g----h----i----j|
                         0    1    2    3    4    5    6    7    8    9
                    |----A----B----C----D----E----F----G----H----I-   J|
*/
/*
Output
run$ next => [----- zip Start   -----]
run$ next => a,0,A
run$ next => b,1,B
run$ next => c,2,C
run$ next => d,3,D
run$ next => e,4,E
run$ next => f,5,F
run$ next => g,6,G
run$ next => h,7,H
run$ next => i,8,I
run$ next => j,9,J
run$ next => [----- zip End   -----]
*/

/**
 * Wait for the first observalbe to complete then start the next observable
 */
const concat$ = concat(alphabets$, numbers$).pipe(catchError(error => of(error)));
const concatTestCase$ = concatAll$('concat', concat$);
/*
Marble Diagram:
alphabets$ => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$   => |--0--1--2--3--4--5--6--7--8--9|

output     => |-a-b-c-d-e-f-g-h-i-j-k-l-m0123456789|
*/
/*
Output
run$ next => [----- concat Start   -----]
run$ next => a
run$ next => b
run$ next => c
run$ next => d
run$ next => e
run$ next => f
run$ next => g
run$ next => h
run$ next => i
run$ next => j
run$ next => k
run$ next => l
run$ next => m
run$ next => 0
run$ next => 1
run$ next => 2
run$ next => 3
run$ next => 4
run$ next => 5
run$ next => 6
run$ next => 7
run$ next => 8
run$ next => 9
run$ next => [----- concat End   -----]
*/

const merge$ = merge(alphabets$, numbers$).pipe(catchError(error => of(error)));
const mergeTestCase$ = concatAll$('merge', merge$);
/*
Marble Diagram:
alphabets$ => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$   => |--0--1--2--3--4--5--6--7--8--9|

output     => |-a0b-c-d2e-f-g4h-i-j6k-l-m8--9|
                    1     3     5     7
*/
/*
Output
run$ next => [----- merge Start   -----]
run$ next => a
run$ next => 0
run$ next => b
run$ next => 1
run$ next => c
run$ next => d
run$ next => 2
run$ next => e
run$ next => 3
run$ next => f
run$ next => g
run$ next => 4
run$ next => h
run$ next => 5
run$ next => i
run$ next => j
run$ next => 6
run$ next => k
run$ next => 7
run$ next => l
run$ next => m
run$ next => 8
run$ next => 9
run$ next => [----- merge End   -----]
*/

const mergeAll$ = alphabets$.pipe(map(x => numbers$),mergeAll(),catchError(error => of(error)));
const mergeAllTestCase$ = concatAll$('mergeAll', mergeAll$);
/*
Marble Diagram:
alphabets$ => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$   => |--0--1--2--3--4--5--6--7--8--9|

output     => |-a0b-c-d2e-f-g4h-i-j6k-l-m8--9|
                    1     3     5     7
*/
/*
Output
run$ next => [----- merge Start   -----]
run$ next => a
run$ next => 0
run$ next => b
run$ next => 1
run$ next => c
run$ next => d
run$ next => 2
run$ next => e
run$ next => 3
run$ next => f
run$ next => g
run$ next => 4
run$ next => h
run$ next => 5
run$ next => i
run$ next => j
run$ next => 6
run$ next => k
run$ next => 7
run$ next => l
run$ next => m
run$ next => 8
run$ next => 9
run$ next => [----- merge End   -----]
*/

const endWith$ = alphabets$.pipe(endWith(numbers), catchError(error => of(error)));
const endWithTestCase$ = concatAll$('endWith', endWith$);
/*
Marble Diagram:
alphabets$ => |-a-b-c-d-e-f-g-h-i-j-k-l-m|
numbers$   => |--0--1--2--3--4--5--6--7--8--9|

output     => |-a0b-c-d2e-f-g4h-i-j6k-l-m8--9|
                    1     3     5     7
*/
/*
Output
run$ next => [----- endWith Start   -----]
run$ next => a
run$ next => b
run$ next => c
run$ next => d
run$ next => e
run$ next => f
run$ next => g
run$ next => h
run$ next => i
run$ next => j
run$ next => k
run$ next => l
run$ next => m
run$ next => 0,1,2,3,4,5,6,7,8,9
run$ next => [----- endWith End   -----]
*/

/**
 * Use combineLatestAll Like forkjoin in sequence
 * Combine All Obserables in sequence and return an array of values
 */
const combineObservables$ = from([of(1).pipe(delay(500)),of(2),of(3),of(4)]).pipe(combineLatestAll());
const combineObservablesTestCase$ = concatAll$('combineObservables', combineObservables$);
/*
  output:
  [1,2,3,4]
*/

/**
 * Use switchMap
 */
const switchMap$ = alphabets$.pipe(switchMap(x => numbers$)).pipe(catchError(error => of(error)));
const switchMapTestCase$ = concatAll$('switchMap', switchMap$);
/*
  output:
run$ next => [----- switchMap Start   -----]
run$ next => 0
run$ next => 1
run$ next => 2
run$ next => 3
run$ next => 4
run$ next => 5
run$ next => 6
run$ next => 7
run$ next => 8
run$ next => 9
run$ next => [----- switchMap End   -----]
*/

/**
 * Use mergeMap
 */
const mergeMap$ = alphabets$.pipe(take(3), mergeMap(alph => numbers$.pipe(take(3), map(num => `${alph}, ${num}` )))).pipe(catchError(error => of(error)));
const mergeMapTestCase$ = concatAll$('mergeMap', mergeMap$);
/*
Marble Diagram:
alphabets$ => |a-b-c|
num for a  => |0--1--2|
num for b  =>   |0--1--2|
num for c  =>     |0--1--2|

output     => |a-bacbacb-c|
               0 0101212 2
*/
/*
  output: 130 values
run$ next => [----- mergeMap Start   -----]
run$ next => a, 0
run$ next => b, 0
run$ next => a, 1
run$ next => c, 0
run$ next => b, 1
run$ next => a, 2
run$ next => c, 1
run$ next => b, 2
run$ next => c, 2
run$ next => [----- mergeMap End   -----]
*/


const run$ = concat(
  // forkJoinTestCase$,
  // combineAllTestCase$,
  // combineLatestTestCase$,
  // zipTestCase$,
  // concatTestCase$,
  // switchMapTestCase$,
  // mergeTestCase$,
  // mergeAllTestCase$,
  // mergeMapTestCase$,
  // endWithTestCase$,
  combineObservablesTestCase$,
).pipe(catchError(error => of(error)));

run$.subscribe(
  val => console.log(`run$ next => ${val}`),
  error => console.log(`run$ error => ${val}`),
  () => console.log(`run$ completed`)
);
