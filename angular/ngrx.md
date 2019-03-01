# NgRx

---
> ### Get Store data from effect

```ts
myData$ = this.action$.ofType( myAction.Type )
.pipe(
  map((action: store.action) => action.payload),
  withLatestFrom(this.store.select(getData))
  switchMap(([lastSelected, allData]) => {
    return of(new store.action)
  })
);

constructor(
  private myService: MService
) {
  this.myFunction = this.myService.myFuntion;
}
```

