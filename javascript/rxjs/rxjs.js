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

/**
 * Fetch Data from api
 */
// Get Method
rxjs.fetch.fromFetch('https://reqres.in/api/users')
  .pipe(mergeMap((response) => response.json()))
  .subscribe({
    next: (data) => {
      console.log('fetch data', data);
    },
    error: err => { console.error(err) }
  });;
 
  
/**
 * Post Method with json
 */
 rxjs.fetch.fromFetch('https://reqres.in/api/users', {
  method: 'POST',
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    "name": 'User 1',
  }),
  selector: response => response.json()
})
.pipe(
  map(response => response.data),
)
.subscribe({
  next: (data) => {
    console.log('fetch data', data);
  },
  error: err => { console.error(err) }
});
 
  
/**
 * Post Method with form data in JSON format
 */
 rxjs.fetch.fromFetch('https://reqres.in/api/users', {
  method: 'POST',
  headers: {
    'Accept': 'application/json',
    "content-type": "application/x-www-form-urlencoded",
  },
  body: new URLSearchParams({
    "name": 'User 1',
  }),
  selector: response => response.json()
})
.pipe(
  map(response => response.data),
)
.subscribe({
  next: (data) => {
    console.log('fetch data', data);
    buildResponsiveTabletView('repertoireTabletViewContainer', tableDef, pageLanguage, data);
  },
  error: err => { console.error(err) }
});
 
  
/**
 * Post Method with form data in Query String
 */
 rxjs.fetch.fromFetch('https://reqres.in/api/users', {
  method: 'POST',
  headers: {
    'Accept': 'application/json',
    "content-type": "application/x-www-form-urlencoded",
  },
  body: "name=User 1",
  selector: response => response.json()
})
.pipe(
  map(response => response.data),
)
.subscribe({
  next: (data) => {
    console.log('fetch data', data);
    buildResponsiveTabletView('repertoireTabletViewContainer', tableDef, pageLanguage, data);
  },
  error: err => { console.error(err) }
});


