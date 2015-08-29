# ![b-html](https://cloud.githubusercontent.com/assets/1221346/9085449/cab43882-3bb7-11e5-825e-f7db99cadfb8.png)

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
<!doctype html
<html
  @lang en
  <head
    </meta
      @charset utf-8
    <title
      TITLE
  <body
    <!--comment
    <h1
      @class title
      HEADLINE
    <p
      Hello, b-html!
      >@bouzuya
      </img
        @alt sample image
        @src /images/sample.png
```

index.html (compiled b-html && formatted for demo) :

```html
<!DOCTYPE html>
<html
  lang="en"
  >
  <head>
    <meta
      charset="utf-8"
      />
    <title>
      TITLE
    </title>
  </head>
  <body>
    <!--comment-->
    <h1
      class="title"
      >
      HEADLINE
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

<table>
    <tr>
      <th>Prefix</th>
      <th>Type</th>
      <th>Parent</th>
      <th>Child</th>
      <th>Examples</th>
    </tr>
    <tr>
      <td><code>  </code> (2 space)</td>
      <td>-</td>
      <td>-</td>
      <td>-</td>
      <td>See: <a href="https://en.wikipedia.org/wiki/Off-side_rule">Off-side rule</a></td>
    </tr>
    <tr>
      <td><code>&lt;</code></td>
      <td>'element'</td>
      <td>MAY</td>
      <td>MAY</td>
      <td><code>&lt;p</code> -> <code>&lt;p&gt;&lt;/p&gt;</code></td>
    </tr>
    <tr>
      <td><code>&lt;/</code></td>
      <td>'empty element'</td>
      <td>MAY</td>
      <td>MUST NOT</td>
      <td><code>&lt;/img</code> -> <code>&lt;img /&gt;</code></td>
    </tr>
    <tr>
      <td><code>&lt;!--</code></td>
      <td>'comment'</td>
      <td>MAY</td>
      <td>MUST NOT</td>
      <td><code>&lt;--xyz</code> -> <code>&lt;!--xyz--&gt;</code></td>
    </tr>
    <tr>
      <td><code>&lt;!doctype html</code></td>
      <td>'doctype'</td>
      <td>MAY</td>
      <td>MUST NOT</td>
      <td><code>&lt;!doctype html</code> -> <code>&lt;!DOCTYPE html&gt;</code><br />See: <a href="#doctypes">#doctypes</a></td>
    </tr>
    <tr>
      <td><code>@</code></td>
      <td>'attribute'</td>
      <td>MUST</td>
      <td>MUST NOT</td>
      <td><code>@class foo</code> -> <code>class="foo"</code></td>
    </tr>
    <tr>
      <td><code>&gt;</code></td>
      <td>'text'</td>
      <td>MAY</td>
      <td>MUST NOT</td>
      <td>
        <code>&gt;text</code> -> <code>text</code><br />
        <code>&gt;&lt;text</code> -> <code>&lt;text</code><br />
        <code>&gt;@text</code> -> <code>@text</code><br />
        <code>&gt;&gt;text</code> -> <code>&gt;text</code><br />
        <code>&gt;|text</code> -> <code>|text</code>
      </td>
    </tr>
    <tr>
      <td><code>|</code></td>
      <td>'new line text'</td>
      <td>MAY</td>
      <td>MUST NOT</td>
      <td>
        <code>|text</code> -> <code>&lt;NL&gt;text</code><br />
        <code>|&lt;text</code> -> <code>&lt;NL&gt;&lt;text</code><br />
        <code>|@text</code> -> <code>&lt;NL&gt;@text</code><br />
        <code>|&gt;text</code> -> <code>&lt;NL&gt;&gt;text</code><br />
        <code>||text</code> -> <code>&lt;NL&gt;|text</code>
      </td>
    </tr>
    <tr>
      <td>(others)</td>
      <td>'text' (default)</td>
      <td>MAY</td>
      <td>MUST NOT</td>
      <td><code>text</code> -> <code>text</code></td>
    </tr>
</table>

Try: [Demo](http://b-html.github.io/b-html-demo/) ( [b-html/b-html-demo](https://github.com/b-html/b-html-demo/) )

### Doctypes

- `<!doctype html` -> (HTML 5)
- `<!doctype html 5` -> (HTML 5)
- `<!doctype html 4.01 strict` -> (HTML 4.01 Strict)
- `<!doctype html 4.01 transitional` -> (HTML 4.01 Transitional)
- `<!doctype html 4.01 frameset` -> (HTML 4.01 Frameset)
- `<!doctype html strict` -> (HTML 4.01 Strict)
- `<!doctype html transitional` -> (HTML 4.01 Transitional)
- `<!doctype html frameset` -> (HTML 4.01 Frameset)
- `<!doctype xhtml 1.0 strict` -> (XHTML 1.0 Strict)
- `<!doctype xhtml 1.0 transitional` -> (XHTML 1.0 Transitional)
- `<!doctype xhtml 1.0 frameset` -> (XHTML 1.0 Frameset)
- `<!doctype xhtml strict` -> (HTML 1.0 Strict)
- `<!doctype xhtml transitional` -> (HTML 1.0 Transitional)
- `<!doctype xhtml frameset` -> (HTML 1.0 Frameset)
- `<!doctype xhtml 1.1` -> (XHTML 1.1)
- `<!doctype xhtml basic` -> (XHTML Basic 1.1)
- `<!doctype xhtml basic 1.0` -> (XHTML Basic 1.0)
- `<!doctype xhtml basic 1.1` -> (XHTML Basic 1.1)
- `<!doctype xhtml mobile` -> (XHTML Mobile 1.2)
- `<!doctype xhtml mobile 1.0` -> (XHTML Mobile 1.0)
- `<!doctype xhtml mobile 1.1` -> (XHTML Mobile 1.1)
- `<!doctype xhtml mobile 1.2` -> (XHTML Mobile 1.2)
- `<!doctype html PUBLIC ...` -> <!DOCTYPE html PUBLIC ...>

## Related Projects

- [b-html/b-html-cli](https://github.com/b-html/b-html-cli) ... A CLI for b-html (b-html to HTML converter).
- [b-html/html2bhtml](https://github.com/b-html/html2bhtml) ... HTML to b-html converter.
- [b-html/gulp-b-html](https://github.com/b-html/gulp-b-html) ... A gulp plugin for b-html.
- [b-html/b-htmlify](https://github.com/b-html/b-htmlify) ... A browserify transform for b-html.
- [b-html/b-html-demo](https://github.com/b-html/b-html-demo) ... A demo for b-html.
- [zakuro9715/vim-b-html](https://github.com/zakuro9715/vim-b-html) ... b-html syntaxt highlighting for vim.
- [b-html/atom-language-b-html](https://github.com/b-html/atom-language-b-html) ... b-html support in Atom.
- [b-html/b-html-logo](https://github.com/b-html/b-html-logo) ... A logo for b-html.

## Badges

[![Circle CI](https://circleci.com/gh/b-html/b-html.svg?style=svg)](https://circleci.com/gh/b-html/b-html)
[![Join the chat at https://gitter.im/b-html/b-html](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/b-html/b-html)

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
