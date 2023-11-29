# Javascript
## Table of Contents
  1. [DOM manipulation](#DOM-manipulation)
      1. [Add element as a sibling](#Add-element-as-a-sibling)
  1. [Clipboard](#Clipboard)
      1. [Copy data to Clipboard](#Copy-data-to-Clipboard)
          1. [Save data in different formats](#Save-data-in-different-formats)

***

## DOM manipulation
### Add element as a sibling
Use: Element.insertAdjacentHTML() with position: 'afterend'
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
Use: clipboardData from Event
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

