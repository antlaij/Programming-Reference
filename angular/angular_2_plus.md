# Angular 4 Reference
---
> ### Debug angular 2+
```js
var sc = ng.probe($0).componentInstance;
```

---
> ### Add disabled to a button or input field
```html
<button id="myButton" type="button" label="Click" [attr.disabled]="disabled?'disabled':null"></button>
```

---
> ### ngClass with Condition
```html
<div [ngClass]="{'success': response?.Success, 'error': !response?.success}"></div>
```

---
> ### ngOnChanges from life cycle hook
```ts
ngOnChanges(changes: SimpleChanges) {
  if (cahnges.myValue) {
  }
}
```

---
> ### Create Function Mapping from service for component
```ts
mappedFunctionName: (arg_01: string) => boolean;

// Setup mapping in constructor
constructor(
  private myService: MyService,
) {
  this.mappedFunctionName = myService.targetFunctionName;
}
```


