# CSS Tutorial
## Table of Contents
1. [CSS Triangle](#CSS-Triangle)
---

## CSS Triangle
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
