# Javascript - Event function

## Table of Contents

* [Dispatch event](#Dispatch-event)
  * [Custom Event type](#Custom-Event-type)


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


