
### Add custom style to existing page by css link
```js
var script = document.createElement('link');
script.type = 'text/css';
script.rel = 'stylesheet';
script.href = 'http://localhost/custom-css/my.css';
document.head.appendChild(script);
```


### Add custom style to existing page by javascript
```js

var pageConfig = {
  highLight: [
      { matchText: 'match text 01', bgColor: `rgba(${255}, ${255}, ${0}, ${0.8})`, tags: ['a', 'td'] },
      { matchText: 'match text 02', bgColor: `rgb(${241}, ${144}, ${241})`, tags: ['a', 'td'] },
  ]
};

var styleSettings = pageConfig.highLight.reduce((accumulator, highLightConfig) => {
  highLightConfig.tags.forEach(tag => {
    let groupKey = tag;
    if(!accumulator.hasOwnProperty(groupKey)){
      accumulator[groupKey] = [];
    }
    accumulator[groupKey].push({...highLightConfig});
  });
  return accumulator;
}, {});


Object.keys(styleSettings).forEach(styleKey => {
  var currentTagSettings = styleSettings[styleKey];
  currentTagSettings.forEach(currentSetting => {
    var allAColl = document.getElementsByTagName(styleKey);
    var aElements = Array.from(allAColl);
    var targetEles = aElements.filter(e => e.innerText === currentSetting.matchText);
    targetEles.forEach(ele => {
        ele.parentElement.style.backgroundColor = currentSetting.bgColor;
        ele.parentElement.style.opacity = 0.8;
    });
  });
});

```
