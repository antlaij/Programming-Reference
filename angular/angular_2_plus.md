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

