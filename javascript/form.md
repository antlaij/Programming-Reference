# Javascript
## Table of Contents
1. [HTML Form](#HTML-Form)
    1. [Get all forms from HTML](#Get-all-forms-from-HTML)
    1. [Print all form values to console](#Print-all-form-values-to-console)
    1. [Form element to JSON](#Form-element-to-JSON)
1. [User Actions](#User-Actions)
    1. [Disable default function from Anchor Tag](#Disable-default-function-from-Anchor-Tag)
        1. [Add a javascript function to attribute "href"](#Add-a-javascript-function-to-attribute-"href")
1. [rxjs](#rxjs)
    1. [Subscribe to Input change event](#Subscribe-to-Input-change-event)
        1. [use: fromEvent](#use:-fromEvent)
    1. [Subscribe to Form change event](#Subscribe-to-Form-change-event)
        1. [use: fromEvent](#use:-fromEvent)

***

## HTML Form
### Get all forms from HTML
```js
var forms = document.getElementsByTagName('form');for(form of forms){console.log( `Form Name: '${form.name}'` )}
var forms = document.getElementsByClassName('class-name');for(form of forms){console.log( `Form Name: '${form.name}'` )}
```

### Print all form values to console
```js
// Print from values to a table
var formData = new FormData(document.getElementsByTagName('form')[0]);console.table(Array.from(formData));
// Print values from first form
var formData = new FormData(document.getElementsByTagName('form')[0]);for(key of formData.keys()){console.log( `${key}: '${formData.get(key)}'` )}

// Print values by the name of the form
var formData = new FormData(document.calculator);for(key of formData.keys()){console.log( `${key}: '${formData.get(key)}'` )}
```

### Form element to JSON
```js
// Print values from first form
let formEleToJson = (formEle) => {
  let targetForm = new FormData(formEle);
  let formData = {};
  for(let key of targetForm.keys()){
    formData[key] = targetForm.get(key);
  }
  return formData;
}
```

## User Actions
### Disable default function from Anchor Tag
#### Add a javascript function to attribute "href"
> From HTML
```html
<a href="javascript:void(0)">Click</a>
```
> From javascript
```js
let userClick = () => {};

let rowEle = document.createElement("A");
rowEle.setAttribute('href', "javascript:void(0)");
rowEle.onclick = userClick;
```


## rxjs
### Subscribe to Input change event
#### use: fromEvent
```js
const { fromEvent, combineLatest } = rxjs;

const inputNameChange$ = [fromEvent(document.formName.inputName, 'change');

const combinedInputsChange$ = combineLatest(
  [
    fromEvent(document.formName.inputName1, 'change'),
    fromEvent(document.formName.inputName2, 'change')
  ]
);
```

### Subscribe to Form change event
#### use: fromEvent
```js
const htmlFormOnKeypress$ = fromEvent(document.formName, 'keypress');

htmlFormOnKeypress$.subscribe({
  next: htmlFormOnKeypressFn,
  error: (e) => console.error(e),
  complete: () => console.info('htmlFormOnKeypress$ completed')
});
```




