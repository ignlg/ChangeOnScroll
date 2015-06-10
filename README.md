# ChangeOnScroll
jQuery plugin that toggles a class name when the element (or another element) goes above the top or of the page.

## Options
```js
  {
    reference: null, // element or jQuery selector of the reference element (by default it's the target element)
    topOffset: 0, // vertical offset to fire the change
    leftOffset: 0, // horizontal offset to fire the change
    verticalScroll: true, // watch vertical scroll
    horizontalScroll: true, // watch horizontal scroll
    className: 'changed-on-scroll' // class to toggle
  }
```

## Example
```js
  $('#topbar').changeOnScroll({
    reference: ".title h1",
    className: 'show-info'
  });
```