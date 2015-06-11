# ChangeOnScroll
jQuery plugin that toggles a class name when the element (or another element) goes above the top (or to the left on horizontal scroll) of the page.

*UPDATE:* Minified version.

## Options
```js
  {
    reference: null, // element or selector of the watched element (by default it's the target element)
    className: 'changed-on-scroll', // class to toggle

    leftOffset: 0, // horizontal offset to fire the change
    topOffset: 0, // vertical offset to fire the change

    horizontalScroll: true, // watch horizontal scroll
    verticalScroll: true // watch vertical scroll
  }
```

## Examples
```js
  $('#topbar').changeOnScroll({
    className: 'show-info',
    reference: ".title h1"
  });
```

```js
  $('#page').changeOnScroll({
    className: 'show-menu',
    reference: "#sidebar",
    verticalScroll: false
  });
```

```js
  // Change photos before they're gone
  $('.photo').changeOnScroll({
    className: 'bye-bye',
    topOffset: -100
  });
```

## Greetings
Thanks to Joseph Cava-Lynch (@bigspotteddog) for his [ScrollToFixed](http://bigspotteddog.github.io/ScrollToFixed/) jQuery plugin.
