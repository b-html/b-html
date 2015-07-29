# b-html

b-html is a little language that compiles into HTML.

## Installation

```
$ npm install b-html
```

## Syntax

b-html:

```b-html
<div
  @class foo
  <h1
    title
  <p
    >@content
    </img
      @src /images/sample.png
```

Compiled: (formatted)

```html
<div class="foo">
  <h1>title</h1>
  <p>@content<img src="/images/sample.png" /></p>
</div>
```

## Usage

```javascript
import bHtml from 'b-html';

bHtml('<p') === '<p></p>';
```

## Syntax Reference

 Symbol | Type          | Examples
--------|---------------|----------------------------------------------------
 `<`    | Element       | `<p` -> `<p></p>`
 `</`   | Empty Element | `</img` -> `<img />`
 `@`    | Attribute     | `@class foo` -> `class="foo"`
 `>`    | Text          | `>text` -> `text`<br />`><text` -> `<text`<br />`>@text` -> `@text`<br />`>>text` -> `>text`
 others | Text         | `text` -> `text`

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
