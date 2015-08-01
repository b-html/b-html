# b-html

An easy HTML syntax sugar.

Concepts:

- It's just HTML (like a [CoffeeScript](http://coffeescript.org))
- Simple syntax
- Off-side rule
- Line-oriented

## Installation

```
$ npm install b-html
```

## Syntax

index.bhtml (b-html) :

```b-html
<!DOCTYPE html>
<html
  <head
    <title
      b-html title
    </meta
      @charset utf-8
  <body
    <!-- HTML5 -->
    <h1
      @class title
      b-html headline
    <p
      Hello, b-html!
      >@bouzuya
      </img
        @alt sample image
        @src /images/sample.png
```

index.html (compiled b-html) :

```html
<!DOCTYPE html>
<html>
  <head>
    <title>
      b-html title
    </title>
    <meta
      charset="utf-8"
      />
  </head>
  <body>
    <!-- HTML5 -->
    <h1
      class="title"
      >
      b-html headline
    </h1>
    <p>
      Hello, b-html!
      @bouzuya
      <img
        alt="sample image"
        src="/images/sample.png"
        />
    </p>
  </body>
</html>
```

## API

```javascript
import bHtml from 'b-html';

bHtml('<p') === '<p></p>';
```

## Syntax Reference

 Symbol          | Node Type     | Examples
-----------------|---------------|-------------------------------------------
 `  ` (2 space)  | -             | See: ["Off-side rule"](https://en.wikipedia.org/wiki/Off-side_rule)
 `<`             | Element       | `<p` -> `<p></p>`
 `</`            | Empty Element | `</img` -> `<img />`
 `<!`            | Comment       | `<!-- aiueo -->` -> `<!-- aiueo -->`<br />`<!DOCTYPE html>` -> `<!DOCTYPE html>`
 `@`             | Attribute     | `@class foo` -> `class="foo"`
 `>`             | Text          | `>text` -> `text`<br />`><text` -> `<text`<br />`>@text` -> `@text`<br />`>>text` -> `>text`
 others          | Text          | `text` -> `text`

## Status Badge

[![Circle CI](https://circleci.com/gh/b-html/b-html.svg?style=svg)](https://circleci.com/gh/b-html/b-html)

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
