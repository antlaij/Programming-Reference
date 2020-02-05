
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
var colorCode = {
  lightOrange: `#EC7063`,
  orange: `#E74C3C`,
  puple: `#8E44AD`,
  blue: `#3498DB`,
  lightBlue: `#c8f8ff`,
  green: `#16A085`,
  lightGreen: `#dcffc8`,
  yellow: `rgba(${255}, ${255}, ${0}, ${0.8})`,
  pink: `rgb(${241}, ${144}, ${241})`,
  grey: `#5D6D7E`,
  lightGrey: `#85929E`,
};

var pageConfig = {
  highLight: [
      { matchText: 'target Text', bgColor: colorCode.yellow, tags: ['a', 'td'] },
      { matchText: 'target Text - 1846', bgColor: colorCode.pink, tags: ['a', 'td'] },
      { matchText: 'target Text - 2209', bgColor: colorCode.lightOrange, tags: ['a', 'td'] },
      { matchText: 'target Text - 1996', bgColor: colorCode.lightGreen, tags: ['a', 'td'] },
      { matchText: 'target Text - 2015', bgColor: colorCode.lightBlue, tags: ['a', 'td'] },
      { matchText: 'target Text - 2237', bgColor: colorCode.puple, tags: ['a', 'td'] },
      { matchText: 'target Text - 2377', bgColor: colorCode.lightGrey, tags: ['a', 'td'] },
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


### Add custom style to existing page by searching data attribute in javascript
```js
var colorCode = {
  white: `#FFFFFF`,
  lightOrange: `#EC7063`,
  orange: `#E74C3C`,
  puple: `#8E44AD`,
  darkPuple: `rgba(${50}, ${0}, ${111}, ${0.8})`,
  blue: `#3498DB`,
  lightBlue: `#c8f8ff`,
  green: `#16A085`,
  lightGreen: `#dcffc8`,
  yellow: `rgba(${255}, ${255}, ${0}, ${0.8})`,
  pink: `rgb(${241}, ${144}, ${241})`,
  grey: `#5D6D7E`,
  lightGrey: `#85929E`,
};

var pageConfig = {
  highLights: [
      { querySelector: `[data-tooltip='my matching text']`, bgColor: colorCode.darkPuple, color: colorCode.white, background: 'linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(52,9,121,1) 45%, rgba(0,198,255,1) 100%)' },
  ]
};

pageConfig.highLights.forEach(highLight => {
    var allAColl = document.querySelectorAll(highLight.querySelector);
    allAColl.forEach(ele => {
        ele.parentElement.parentElement.style.backgroundColor = highLight.bgColor;
        ele.parentElement.parentElement.style.color = highLight.color;
        ele.parentElement.parentElement.style.background = highLight.background;
        // ele.parentElement.style.opacity = 0.8;
    });
  });
```
