# css variable with scss

```css
$main-bg-color: #896eb7;
$main-bg-color-lite: #ab98cc;
$text-bg-color: #c4afd0;
$primary-button-background-color: #723cbd;
$second-button-background-color: #807c86;
$custom-box-shadow: 3px 3px 5px 0px #201e21;

$header-foreground-color: rgb(39, 1, 70);
$header-background-color: #d5d1f7;

$table-foreground-color: #2e2933;
$table-background-color: #c7b9e2;
$alternate-row-color: #baa7f7;
$hover-color: #f0f1bb;

:root {
  --main-bg-color: #{$main-bg-color};
  --main-bg-color-lite: #{$main-bg-color-lite};
  --text-bg-color: #{$text-bg-color};
  --primary-button-background-color: #{$primary-button-background-color};
  --second-button-background-color: #{$second-button-background-color};
  --custom-box-shadow: #{$custom-box-shadow};
}
```


# Use css variable in scss with media query

```css
// The Sass Way
:root {
  --fs-b-lrg: 1rem;
  --fs-h1-lrg: 3rem;
  --fs-h2-lrg: 1.5rem;  
  
  --fs-b-sm: .8rem;
  --fs-h1-sm: 2rem;
  --fs-h2-sm: 1.2rem;
}

h1 {
  font-size: var(--fs-h1-sm);
}

h2 {
  font-size: var(--fs-h2-sm);
}

body {
  font-size: var(--fs-b-sm);
}

@media (min-width: 800px) {
  h1 {
    font-size: var(--fs-h1-lrg);
  }

  h2 {
    font-size: var(--fs-h2-lrg);
  }

  body {
    font-size: var(--fs-b-lrg);
  }
}
```


# Multiple variables in a function
```scss
@mixin css-properties {
  margin: 10px 5px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.use-function {
  @include css-properties;
  align-items: center;
}
```


# Generate css class

```scss
$columns: 12;

%float-styles {
  float: left;
}

@mixin col-x-list {
  @for $i from 1 through $columns {
      .col-#{$i}-m { @extend %float-styles; }
  }
}

@include col-x-list;
```
## Output css
```css
.col-1-m, .col-2-m, .col-3-m, .col-4-m, .col-5-m, .col-6-m, .col-7-m, .col-8-m, .col-9-m, .col-10-m, .col-11-m, .col-12-m {
  float: left;
}
```
