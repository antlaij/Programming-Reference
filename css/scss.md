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
