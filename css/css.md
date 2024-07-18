# CSS Tutorial
## Table of Contents
1. [CSS Triangle](#CSS-Triangle)
---

## Viewport Meta Tag
### Meta tag in Head
```html
<head>
  <meta name="viewport" content="width-device=width, initial-scale-1.0" />
</head>
```

## Container Query
### Container Query Ranges Syntax
```css
.my-container {
  container-type: inline-size;
}
@container ( 100px <= width <= 600px ) {
  .my-container {
    container-type: inline-size;
  }
}
```

## Media Query
### Media Query Ranges Syntax
```css
.my-div {
    background-color: red;
}
@media ( 100px <= width <= 600px ) {
  .my-div {
    background-color: black;
  }
}
```

## CSS Grid
### Change element order responsively
#### When screen size between 800px to 1000px then put the first and second element at the end. Element without order add first.
```html
<div id="css-grid-container">
  <div>column 1</div>
  <div>column 2</div>
  <div>column 3</div>
  <div>column 4</div>
  <div>column 5</div>
  <div>column 6</div>
</div>
```
```css
#css-grid-container {
  height: 3rem;
  display: grid;
  grid-template-columns: 100px 1fr 100px;
  place-items: center;
}

@media ( 800px <= width <= 1000px ) {
  #css-grid-container {
    grid-template-columns: 100px 1fr 100px 1fr;
    div:nth-of-type(1) {
      order: 1;
    }
    div:nth-of-type(2) {
      order: 2;
    }
  }
}
```

## Clamp
### clamp(min, normal, max)
#### From this
```css
.my-container {
  min-width: 300px;
  width: 75%;
  max-width: 600px;
}
```
#### Change to
```css
.my-container {
  width: clamp(300px, 75%, 600px)
}
```

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

#### Content code

|Direction|HEX code|
|---------|-------:|
|UP       |    25B2|
|RIGHT    |    25BA|
|DOWN     |    25BC|
|LEFT     |    25C0|


## Animation

### Properties order
1. animation-duration
2. animation-name
3. animation-timing-function
4. animation-delay
5. animation-iteration-count
6. animation-direction
7. animation-fill-mode
8. animation-play-state
9. animation-timeline

#### Calculate the size base on auto
```css
.animated {
  animation: 3s spinKeyFrames ease-in 1s infinite reverse both running slidein;
}
@keyframes spinKeyFrames {
  0%{

  }
  50%{
    scale: 2;
  }
  100%{
    transform: rotate(360deg);
    border-radius: 50%;
  }
}
```
