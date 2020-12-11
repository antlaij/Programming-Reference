# Angular 2+ Reactive Form Reference

## Table of Contents
1. [Form custom Validators](#Form-custom-Validators)
1. [Enable or Disable a button or input field](#Enable-or-Disable-a-button-or-input-field)



---
> ### Form custom Validators

```ts
this.myForm = this.formBuilder.group({
  formField_001: new FormControl(null, [this.formService.formValidator]),
});
```

```ts
public formValidator(control: AbstractControl): ValidationErrors {
  let tryRegEx = /^[a-z]{1,50}$/;
  return tryRegEx.test(contro.value)? null: {'errorMessage': {value: control.value});
}
```

---
> ### Enable or Disable a button or input field

```html
<button id="myButton" type="button" label="Click" [attr.disabled]="disableMyButton?'disabled':null"></button>
```

```ts
export class testingComponent implements OnInit {
  public disableMyButton: boolean;

  ngOnInit() {
    this.disableMyButton = true;
  }
}
```

```scss
button {
  cursor: pointer;
  &:disabled {
    cursor: not-allowed;
    pointer-events: none;
    opacity: 0.2;
  }
}
```
