## Table of Contents
1. [Show element outside of the parent element](#Show-element-outside-of-the-parent-element)
1. [CSS Selector](#CSS-Selector)
   - [has](has-selector)

---
> ### Show element outside of the parent element

```html
<div class="parent-div">
  <div class="child-div">
  child
  </div>
</div>
```

```css
.parent-div {
  overflow: visible;
}
```


---
> ### **CSS Selector**
> - #### has
```css
.box:has(img.red-border) {
  color: red;
}
```
