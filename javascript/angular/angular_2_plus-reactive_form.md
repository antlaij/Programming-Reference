# Angular 2+ Reactive Form Reference

## Table of Contents
1. [Form custom Validators](#Form-custom-Validators)
1. [Enable or Disable a button or input field](#Enable-or-Disable-a-button-or-input-field)



---
> ### Form Validation

```ts
    this.myForm = this.formBuilder.group(
      {
        notRequire: [""],
        requireField: ["me", [Validators.required]],
        requireFieldWithDefault: ["studyroom", [Validators.required]],
        requiredMin2: ["", [Validators.required, Validators.minLength(2)]],
        disabledField: {value:null, disabled: true},
        requireWithPattern: ["10.99", [Validators.required, Validators.pattern("^[0-9]+.[0-9]{2}$")]],
        nullOrPattern: ["", [Validators.pattern("^$|^[0-9]+.[0-9]{2}$")]],
        dateField: new FormControl(new Date(), Validators.required)
      },
    );
  }
});
```



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
