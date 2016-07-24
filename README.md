# ![b-html](https://cloud.githubusercontent.com/assets/1221346/9085449/cab43882-3bb7-11e5-825e-f7db99cadfb8.png)

An easy HTML syntax sugar.

Concepts:

- It's just HTML (like a [CoffeeScript](http://coffeescript.org))
- [Off-side rule](https://en.wikipedia.org/wiki/Off-side_rule)
- [Simple syntax](#syntax-reference)

[Try b-html (real-time preview demo)][demo]

Twitter hashtag is [#bhtml](https://twitter.com/hashtag/bhtml).

## Simple Example

index.bhtml (b-html) :

```b-html
<!doctype html
<html
  <head
    </meta
      @charset UTF-8
    <title
      b-html example
  <body
    <!--comment example
    <p
      Hello, b-html!
      <a
        @href https://github.com/bouzuya
        >@bouzuya
```

index.html (compiled b-html && formatted for demo) :

```html
<!DOCTYPE html>
<html>
  <head>
    <meta
      charset="utf-8"
      />
    <title>
      b-html example
    </title>
  </head>
  <body>
    <!--comment eample-->
    <p>
      Hello, b-html!
      <a
        href="https://github.com/bouzuya"
        >
        @bouzuya
      </a>
    </p>
  </body>
</html>
```

[Try b-html (real-time preview demo)][demo]

## Installation

```
$ npm install b-html
```

See also: [#api](#api)

### with CLI

```
$ npm install -g b-html-cli
```

See also: [b-html/b-html-cli][]

### with gulp

```
$ npm install gulp-b-html
```

See also: [b-html/gulp-b-html][]

### with browserify

```
$ npm install b-htmlify
```

See also: [b-html/b-htmlify][]

## Syntax Reference

`indent (spaces)` + `prefix` + `content`

<table>
    <tr>
      <th>Prefix</th>
      <th>Type</th>
      <th>Parent</th>
      <th>Child</th>
      <th>Examples</th>
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

[Try b-html (real-time preview demo)][demo]

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

## API

### signature

- `bHtml(source: string): string`
- `bHtml(source: string, options: { format: any }): any`

params:

- source ... b-html source string.
- options.format ... formatter function. see also: [#formatter signature](#formatter-signature)

See the following examples.

### no options

```javascript
import assert from 'assert';
import bHtml from 'b-html';

assert(bHtml('<p') === '<p></p>');
```

### with `format` option

```javascript
import assert from 'assert';
import bHtml from 'b-html';

let source = '<p';
let options = {
  format(nodes, options) {
    assert(nodes[0].type === 'element');
    assert(nodes[0].name === 'p');
    assert.deepEqual(nodes[0].attributes, []);
    assert.deepEqual(nodes[0].children, []);
    assert.deepEqual(options, { format });
    let n = nodes[0];
    return `<${n.name}>My formatter!</${n.name}>`;
  }
};
assert(bHtml(source, options) === '<p>My formatter!</p>');
```

#### formatter signature

`format(nodes: Array<Node>, options: {}): any`

- Node
  - type: string
- Element extends Node
  - (type === 'element')
  - name: string
  - attributes: Array<Attribute>
  - children: Array<Node>
- EmptyElement extends Node
  - (type === 'empty element')
  - name: string
  - attributes: Array<Attribute>
  - children: Array<Node>
- Comment extends Node
  - (type === 'comment')
  - value: string
- Doctype extends Node
  - (type === 'doctype')
  - value: string
- Attribute extends Node
  - (type === 'attribute')
  - name: string
  - value: string
- Text: string
  - (type === 'text')
  - value: string
- NewLineText
  - (type === 'new line text')
  - value: string

## Related Projects

- [b-html/b-html-cli][] ... A CLI for b-html (b-html <-> HTML converter).
- [b-html/gulp-b-html][] ... A gulp plugin for b-html.
- [b-html/b-htmlify][] ... A browserify transform for b-html.
- [b-html/b-html-demo][] ... A demo for b-html.
- [zakuro9715/vim-b-html][] ... b-html syntaxt highlighting for vim.
- [b-html/atom-language-b-html][] ... b-html support in Atom.
- [b-html/b-html-logo][] ... A logo for b-html.
- [b-html/html2bhtml][] ... HTML to b-html converter.

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
[demo]: http://b-html.org/b-html-demo/
[b-html/atom-language-b-html]: https://github.com/b-html/atom-language-b-html
[b-html/b-html-cli]: https://github.com/b-html/b-html-cli
[b-html/b-html-demo]: https://github.com/b-html/b-html-demo
[b-html/b-html-logo]: https://github.com/b-html/b-html-logo
[b-html/b-htmlify]: https://github.com/b-html/b-htmlify
[b-html/gulp-b-html]: https://github.com/b-html/gulp-b-html
[b-html/html2bhtml]: https://github.com/b-html/html2bhtml
[zakuro9715/vim-b-html]: https://github.com/zakuro9715/vim-b-html
