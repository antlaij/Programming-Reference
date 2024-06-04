# Javascript - Event function

## Table of Contents

1. [Dispatch event](#Dispatch-event)
    1. [Custom Event type](#Custom-Event-type)
    1. [Trigger event from a form element](#Trigger-event-from-a-form-element)
    1. [Find all elements by selector and Click each element with mouse](#Find-all-elements-by-selector-and-Click-each-element-with-mouse)


## Dispatch event
### Custom Event type
```js
/**
* Dispatch event by custom Event type
*/
let dispatchCustomEvent = (targetEle, eventType) => {
  switch(eventType) {
    case 'change':
      targetEle.dispatchEvent(new Event('change'));
      break;
    case 'keyup':
      targetEle.dispatchEvent(new KeyboardEvent('keyup',  {'key':''}));
      break;
  }
}
```

### Trigger event from a form element
Use: Element.dispatchEvent(new Event(Event Type, options))
Keyboard Event
```js
document.formName.inputName.dispatchEvent(new Event('keyup'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('keydown'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('keypress'), { bubbles: true, cancelable: false });
```
Mouse Event
```js
document.formName.inputName.dispatchEvent(new Event('mousedown'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('mouseup'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('click'), { bubbles: true, cancelable: false });
```

#### Find all elements by selector and Click each element with mouse
Use: Element.dispatchEvent(new Event(Event Type, options))
Mouse Event
```js
for(i=0; i<5; i++) {
    document.querySelectorAll('[data-section-name="SEC13"] .seat.is-available')[i]
      .dispatchEvent(new MouseEvent("click", { "view": window, "bubbles": true, "cancelable": false }));
}
```


## Event - pageshow
### Detect the page is load from history or not

#### Method 1: using window.navigation.canGoForward
```js
const isLoadFromHistory: () => {
  return window.navigation.canGoForward;
}
```

#### Method 2: using event listener for pageshow
```js
window.addEventListener('pageshow', (event) => {
  console.log('event.persisted', event.persisted);
  if(event.persisted) console.log('Page is loaded from history or back button click');
  else console.log('Page is not loaded from history');
});
```

#### Method 3: using hidden form to hold the a flag
```html
<form id="hiddenForm" name="hiddenForm" class="hidden"><input type="text" name="hasPageLoaded" value="0"></form>
```
```js
let searchControl = document.getElementById('searchControl');
let searchAgainControl = document.getElementById('searchAgainControl');

let submitUniForm = () => {
  if(document.hiddenForm && document.hiddenForm.hasPageLoaded){
    document.hiddenForm.hasPageLoaded.value = '1';
  }
  return true;
}
```
