# xpath selector

## select all DIV, A tag in all level
```js
$x('//div');
$x('//a');
```

## select all child A tag within a DIV tag
```js
$x('//div//a');
```

## select all child A tag with link text = '123456' within a DIV tag
```js
$x('//div//a[text()="123456"');
```

## select all child A tag starts with inner text = '123' within a DIV tag
### Matched:
### xpath selector
```js
$x('//div//a[starts-with(text(),'123')]');
```
```html
<div>
  <a>123456</a>
</div>
```

## select with text equals
```js
/span[text()="123456"]
```
