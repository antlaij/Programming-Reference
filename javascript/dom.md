# Javascript
## Table of Contents
+ [DOM manipulation](#DOM-manipulation)
  - [Add element as a sibling](#Add-element-as-a-sibling)
+ [Clipboard](#Clipboard)
  - [Copy data to Clipboard](#Copy-data-to-Clipboard)
+ [Event](#Event)
  - [Trigger event from a form element](#Trigger-event-from-a-form-element)




## DOM manipulation
### Add element as a sibling
#### Use: Element.insertAdjacentHTML() with position: 'afterend'
```js
  const target = document.querySelector('#target');
  const newElement = document.createElement("span");
  newElement.innerHTML="This is a test";
  target.insertAdjacentHTML('afterend', newElement);
  target.insertAdjacentHTML('afterend', '<strong>inserted text</strong>');
```


## Clipboard
### Copy data to Clipboard
#### Save data in different formats
#### Use: clipboardData from Event
```js
let displayEle = document.createElement("button");
displayEle.innerText = 'Copy';
displayEle.onclick = (evt) => {
  let listener = (e) => {
    e.clipboardData.setData("text/plain", `Data to copy`);
    e.clipboardData.setData("text/html", `<span>Data to copy</span>`);
    e.preventDefault();
  }
  document.addEventListener("copy", listener);
  document.execCommand("copy", true);
  document.removeEventListener("copy", listener);
};
```


## Event
### Trigger event from a form element
#### Use: Element.dispatchEvent(new Event(Event Type, options))
#### Keyboard Event
```js
document.formName.inputName.dispatchEvent(new Event('keyup'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('keydown'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('keypress'), { bubbles: true, cancelable: false });
```
#### Keyboard Event
```js
document.formName.inputName.dispatchEvent(new Event('mousedown'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('mouseup'), { bubbles: true, cancelable: false });
document.formName.inputName.dispatchEvent(new Event('click'), { bubbles: true, cancelable: false });
```



