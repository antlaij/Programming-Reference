# CSS Themes

## Use OS color scheme
### Media query - prefers-color-scheme
```css
@media (prefers-color-scheme: dark) {
  body {
    background-color: #000;
  }
}

@media (prefers-color-scheme: light) {
  body {
    background-color: #fff;
  }
}
```

---

## Multi theme templates
### CSS

```css
:root {
  --th-background: hsl(0deg 0% 5%);;
  --th-menu: hsl(0deg 0% 10%);
  --th-surface: hsl(0deg 0% 15%);
  --th-primary: hsl(267deg 95% 76%);
  --th-secondary: hsl(174deg 97% 43%);
  --th-on-background: hsl(0deg 0% 63%);
  --th-on-menu: var(--th-primary);
  --th-on-surface: hsl(0deg 0% 60%);
  --th-on-primary: hsl(0deg 0% 0%);
  --th-on-secondary: hsl(0deg 0% 0%);
}

body {
  background: var(--th-background);
  color: var(--th-on-background);
}

.color-picker {
   input[type="radio"] {
    appearance: none;
    width: 0.5rem;
    height: 0.5rem;
    outline: 3px solid var(--radio-color, currentColor);
    outline-offset: 2px;
    border-radius: 50%;
    &:checked {
      background-color: var(--radio-color);
    }
    &#light {
      --radio-color: gray;
    }
    &#pink {
      --radio-color: hsl(341deg 52% 77%);
    }
    &#blue {
      --radio-color: hsl(202deg 55% 39%);
    }
    &#green {
      --radio-color: hsl(173, 90%, 15%);
    }
    &#dark {
      --radio-color: #232323;
    }
  }
}

/* Radio button color */
.pink {
  --clr-body-bg: hsl(310 50% 60%);
  --clr-menu-bg: hsl(310 50% 80%);
  --clr-card-bg: hsl(310 50% 85%);
  --clr-heading: hsl(310 50% 25%);
  --clr-text: hsl(310 50% 15%);
}

.blue {
  --clr-body-bg: hsl(196 50% 60%);
  --clr-menu-bg: hsl(196 50% 63%);
  --clr-card-bg: hsl(196 50% 65%);
  --clr-heading: hsl(196 50% 25%);
  --clr-text: hsl(196 50% 45%);
}

.green {
  --clr-body-bg: hsl(109 50% 90%);
  --clr-menu-bg: hsl(109 50% 80%);
  --clr-card-bg: hsl(109 50% 85%);
  --clr-heading: hsl(109 50% 25%);
  --clr-text: hsl(109 50% 15%);
}

.dark {
  --clr-body-bg: hsl(209 50% 10%);
  --clr-menu-bg: hsl(209 50% 80%);
  --clr-card-bg: hsl(209 50% 85%);
  --clr-heading: hsl(209 50% 80%);
  --clr-text: hsl(209 50% 90%);
}

/* Change theme colors based on user selection */
:root:has(#pink:checked) {  
  --th-background: hsl(310, 50%, 5%);
  --th-menu: hsl(310, 50%, 10%);
  --th-surface: hsl(310, 50%, 15%);
  --th-primary: hsl(310, 50%, 45%);
  --th-secondary: hsl(310, 60%, 45%);
  --th-on-background: hsl(0deg 0% 87%);
  --th-on-menu: var(--th-primary);
  --th-on-surface: hsl(341deg 52% 77%);
  --th-on-primary: hsl(0deg 0% 0%);
  --th-on-secondary: hsl(0deg 0% 0%);
}

:root:has(#blue:checked) {
  --th-background: hsl(209, 50%, 5%);
  --th-menu: hsl(209, 50%, 10%);
  --th-surface: hsl(209, 50%, 15%);
  --th-primary: hsl(209, 50%, 45%);
  --th-secondary: hsl(209, 60%, 45%);
  --th-on-background: hsl(0deg 0% 87%);
  --th-on-menu: var(--th-primary);
  --th-on-surface: hsl(202deg 55% 39%);
  --th-on-primary: hsl(0deg 0% 0%);
  --th-on-secondary: hsl(0deg 0% 0%);
}

:root:has(#green:checked) {  
  --th-background: hsl(173, 90%, 5%);
  --th-menu: hsl(173, 90%, 10%);
  --th-surface: hsl(173, 90%, 15%);
  --th-primary: hsl(173, 90%, 45%);
  --th-secondary: hwb(173 60% 45%);
  --th-on-background: hsl(76, 60%, 79%);
  --th-on-menu: var(--th-primary);
  --th-on-surface: hsl(180 95% 48%);
  --th-on-primary: hsl(0, 0%, 0%);
  --th-on-secondary: hsl(180, 100%, 0%);
}

:root:has(#dark:checked) {
  --th-background: hsl(0deg 0% 5%);;
  --th-menu: hsl(0deg 0% 10%);
  --th-surface: hsl(0deg 0% 15%);
  --th-primary: hsl(197deg 100% 38%);
  --th-secondary: hsl(174deg 97% 43%);
  --th-on-background: hsl(0deg 0% 63%);
  --th-on-menu: var(--th-primary);
  --th-on-surface: hsl(0deg 0% 70%);
  --th-on-primary: hsl(0deg 0% 0%);
  --th-on-secondary: hsl(0deg 0% 0%);
}
```

### HTML

```html
<header id="header">
  <div class="block-align-right">
    <form class="color-picker" action="">
      <fieldset>
        <legend class="visually-hidden">Pick a color scheme</legend>
        <label for="light" class="visually-hidden">Light</label>
        <input type="radio" id="light" name="theme">
    
        <label for="pink" class="visually-hidden">Pink theme</label>
        <input type="radio" id="pink" name="theme">
    
        <label for="blue" class="visually-hidden">Blue theme</label>
        <input type="radio" id="blue" name="theme">
    
        <label for="green" class="visually-hidden">Green theme</label>
        <input type="radio" id="green" name="theme">
    
        <label for="dark" class="visually-hidden">Dark theme</label>
        <input type="radio" id="dark" name="theme" checked>
      </fieldset>
    </form>
  </div>
</header>
```
