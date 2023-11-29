# Javascript - Event function

## Table of Contents

1. [Dispatch event](#Dispatch-event)
    1. [Custom Event type](#Custom-Event-type)
    1. [Trigger event from a form element](#Trigger-event-from-a-form-element)


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


