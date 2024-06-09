# Javascript - Event function

## Table of Contents
1. [Dispatch event](#Dispatch-event)
    1. [Custom Event type](#Custom-Event-type)
    1. [Trigger event from a form element](#Trigger-event-from-a-form-element)
        1. [Find all elements by selector and Click each element with mouse](#Find-all-elements-by-selector-and-Click-each-element-with-mouse)
1. [Event - copy](#Event---copy)
    1. [Copy data to clipboard from web page](#Copy-data-to-clipboard-from-web-page)
1. [Event - pageshow](#Event---pageshow)
    1. [Detect the page is load from history or not](#Detect-the-page-is-load-from-history-or-not)
        1. [Method 1: using window.navigation.canGoForward](#Method-1:-using-window.navigation.canGoForward)
        1. [Method 2: using event listener for pageshow](#Method-2:-using-event-listener-for-pageshow)
        1. [Method 3: using hidden form to hold the a flag](#Method-3:-using-hidden-form-to-hold-the-a-flag)

***

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


## Event - copy
### Copy data to clipboard from web page
```js
let renderCopyButton = (data, dataset) => {
  let cellEle = document.createElement("span");
  cellEle.style.cssText = 'display: grid; position: relative;';
  let displayEle = document.createElement("button");
  displayEle.setAttribute('aria-label', `copy data`);
  displayEle.classList.add(`tablet-view-cell-ellipsis`, 'button-regular', 'clickable');
  displayEle.style.cssText = 'white-space: nowrap; overflow: hidden; text-overflow: ellipsis;';
  displayEle.innerHTML = (pageLanguage === languages.FR)?'Donn&eacute;es - Copier': 'Copy Data';
  displayEle.onclick = (evt) => {
    let listener = (e) => {

      // Prepare data for the HTML
      let dataToCopy = reformatDataset(dataset);

      // Copy data in plain text
      e.clipboardData.setData("text/plain", `Data:\r\n${jsonToText(dataToCopy)}`);
      // Copy data in HTML format
      e.clipboardData.setData("text/html", `<i>Info.</i> <b>Data</b>. <pre>${JSON.stringify(dataToCopy, null, 2)}</pre>`);
      // e.clipboardData.setData("application/json", JSON.stringify(dataToCopy, null, 2));
      e.preventDefault();
    }
    document.addEventListener("copy", listener);
    document.execCommand("copy", true);
    document.removeEventListener("copy", listener);
    // Show a message to user after copy the data to clipboard
    evt.target.innerHTML = (pageLanguage === languages.FR)?'Donn&eacute;es copi&eacute;es !': 'Data Copied!';
    setTimeout(() => {
      evt.target.innerHTML = (pageLanguage === languages.FR)?'Donn&eacute;es - Copier': 'Copy Data';
    }, 3000);
  };
  cellEle.appendChild(displayEle);
  return cellEle;

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
