# CSS Tutorial
## Table of Contents
1. [CSS Triangle](#CSS-Triangle)
---

## Calculate size
### calc-size()
#### Calculate the size base on auto
```css
.my-container.show {
  height: calc-size(auto);
}
```

## Create Triangle or Arrow from css
### Using border
```css
.triangle-down {
  --shap-side: 20px;
  display:block;
  width: 0;
  height: 0;
  border-left: var(--shap-side) solid transparent;
  border-right: var(--shap-side) solid transparent;
  border-top: var(--shap-side) solid #007080;
}
```
```html
<span class="triangle-down"></span>
```
### Using Hex code
```css
.triangle-down::after {
  content: '\25bc';
  color: green;
}
```
```html
<span class="triangle-down"></span>
```
|Direction|HEX code|
|---------|-------:|
|UP       |    25B2|
|RIGHT    |    25BA|
|DOWN     |    25BC|
|LEFT     |    25C0|
