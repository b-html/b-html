# b-html

An easy HTML syntax sugar.

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

index.html (compiled & formatted) :

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

## Usage

```javascript
import bHtml from 'b-html';

bHtml('<p') === '<p></p>';
```

## Syntax Reference

 Symbol      | Type          | Examples
-------------|---------------|----------------------------------------------
 ` ` (Space) | -             | See: ["Off-side rule"](https://en.wikipedia.org/wiki/Off-side_rule)
 `<`         | Element       | `<p` -> `<p></p>`
 `</`        | Empty Element | `</img` -> `<img />`
 `<!`        | Comment       | `<!-- aiueo -->` -> `<!-- aiueo -->`<br />`<!DOCTYPE html>` -> `<!DOCTYPE html>`
 `@`         | Attribute     | `@class foo` -> `class="foo"`
 `>`         | Text          | `>text` -> `text`<br />`><text` -> `<text`<br />`>@text` -> `@text`<br />`>>text` -> `>text`
 others      | Text          | `text` -> `text`

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
