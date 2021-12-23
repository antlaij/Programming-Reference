const { interval, of, iif } = require('rxjs');
const { mergeMap, take, tap } = require('rxjs/operators');

/**
 * If else condition
 */
const oddObservable$ = of('<---  ODD  -->');
const evenObservable$ = of('<---  EVEN  -->');

interval(1000).pipe(
  tap(value => console.log(`interval: ${value}`)),
  mergeMap(value =>
    iif(
      () => (value % 2),
      oddObservable$,
      evenObservable$
    )),
    take(5),
).subscribe(console.log);
