# b-html

[![Join the chat at https://gitter.im/b-html/b-html](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/b-html/b-html?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

An easy HTML syntax sugar.

Concepts:

- It's just HTML (like a [CoffeeScript](http://coffeescript.org))
- Simple syntax
- Off-side rule
- Line-oriented

See: [Demo](http://b-html.github.io/b-html-demo/) ( [b-html/b-html-demo](https://github.com/b-html/b-html-demo/) )

## Installation

```
$ npm install b-html
```

## Syntax

index.bhtml (b-html) :

```b-html
><!DOCTYPE html>
<html
  <head
    <title
      b-html title
    </meta
      @charset utf-8
  <body
    ><!-- HTML5 -->
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

 Symbol          | Name          | Parent   | Child    | Examples
-----------------|---------------|----------|----------|---------------------
 `  ` (2 space)  | -             | -        | -        | See: ["Off-side rule"](https://en.wikipedia.org/wiki/Off-side_rule)
 `<`             | Element       | MAY      | MAY      | `<p` -> `<p></p>`
 `</`            | Empty Element | MAY      | MUST NOT | `</img` -> `<img />`
 `<!`            | Comment       | MAY      | MUST NOT | `<!` -> (remove)
 `@`             | Attribute     | MUST     | MUST NOT | `@class foo` -> `class="foo"`
 `>`             | Text          | MAY      | MUST NOT | `>text` -> `text`<br />`><text` -> `<text`<br />`>@text` -> `@text`<br />`>>text` -> `>text`<br />`><!-- comment -->` -> `<!-- comment -->`<br />`><!DOCTYPE html>` -> `<!DOCTYPE html>`<br />`><?xml version="1.0"?>` -> `<?xml version="1.0"?>`
 others          | Text          | MAY      | MUST NOT | `text` -> `text`

 See: [Demo](http://b-html.github.io/b-html-demo/) ( [b-html/b-html-demo](https://github.com/b-html/b-html-demo/) )

## Related Projects

- [b-html/gulp-b-html](https://github.com/b-html/gulp-b-html/) ... A gulp plugin for b-html.
- [b-html/b-html-demo](https://github.com/b-html/b-html-demo/) ... A demo for b-html.

## Status Badge

[![Circle CI](https://circleci.com/gh/b-html/b-html.svg?style=svg)](https://circleci.com/gh/b-html/b-html)

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
