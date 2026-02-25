# CSS Tutorial
## Table of Contents
  1. [Viewport Meta Tag](#Viewport-Meta-Tag)
      1. [Meta tag in Head](#Meta-tag-in-Head)
  1. [Container Query](#Container-Query)
      1. [Container Query Ranges Syntax](#Container-Query-Ranges-Syntax)
  1. [Media Query](#Media-Query)
      1. [Media Query Ranges Syntax](#Media-Query-Ranges-Syntax)
  1. [CSS Grid](#CSS-Grid)
      1. [Change element order responsively](#Change-element-order-responsively)
          1. [When screen size between 800px to 1000px then put the first and second element at the end. Element without order add first.](#When-screen-size-between-800px-to-1000px-then-put-the-first-and-second-element-at-the-end.-Element-without-order-add-first.)
                                                                      1. [{](#{)
  1. [Clamp](#Clamp)
      1. [clamp(min, normal, max)](#clamp(min,-normal,-max))
          1. [From this](#From-this)
          1. [Change to](#Change-to)
  1. [Calculate size](#Calculate-size)
      1. [calc-size()](#calc-size())
          1. [Calculate the size base on auto](#Calculate-the-size-base-on-auto)
  1. [Create Triangle or Arrow from css](#Create-Triangle-or-Arrow-from-css)
      1. [Using border](#Using-border)
      1. [Using Hex code](#Using-Hex-code)
          1. [Content code](#Content-code)
  1. [Input](#Input)
      1. [Checkbox to switch](#Checkbox-to-switch)
                                                      1. [{](#{)
  1. [Animation](#Animation)
      1. [Properties order](#Properties-order)
          1. [Calculate the size base on auto](#Calculate-the-size-base-on-auto)

***

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

## Color
### Relative color by using "from"
```css
:root {
  --color: rgb(255, 0, 255)
}

.box-1 {
  background: rgb(from var(--color) r g b)
}
```
#### Remove Red from the color variable 
```css
.box-1 {
  background: rgb(from var(--color) 0 g b)
}
```
#### Calculation = add 200 to Red and multiply 0.5 to blue
```css
.box-1 {
  background: rgb(from var(--color) calc(r + 200) g calc(b * 0.5))
}
```
#### Transparent effect
```css
.box-1 {
  background: rgb(from var(--color) r g b / 0.25)
}
```
#### Add more Transparent to the color
```css
.box-1 {
  background: rgb(from var(--color) r g b / calc(alpha + 0.2))
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


---
## Input

### Checkbox to switch
```html
  <div id="css-switch-box">
    <label>
      <input type="checkbox" />
      Switch
    </label>
  </div>
```
```css
#css-switch-box {
  input {
    appearance: none;
    position: relative;
    display: inline-block;
    height: 1.65rem;
    aspect-ratio: 16 / 10;
    vertical-align: middle;
    background: rgb(58, 57, 57);
    border-radius: 2rem;
    box-shadow: 0px 1px 3px #0003 inset;
    transition: 0.25s linear background;

    &:before {
      content: '';
      display: block;
      height: 1.25rem;
      aspect-ratio: 1 / 1;
      background: #fff;
      position: absolute;
      top: 0.2rem;
      left: 0.2rem;
      border-radius: 1.2rem;
      box-shadow: 0px 1px 3px #0003 inset;
      transition: 0.25s linear transform;
      transform: translateX(0rem)
    }
    
    &:checked {
      background: rgb(42, 209, 42);
    }

    &:checked::before {
      transform: translateX(1rem);
    }

    &:focus-visible {
      outline:  2px solid dodgerblue;
      outline-offset: 2px;
    }

  }
}
```


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
