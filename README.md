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
  @id bar
  <h1
    title
  <p
    content
```

Compiled: (formatted)

```html
<div class="foo" id="bar">
  <h1>title</h1>
  <p>content</p>
</div>
```

## Usage

```javascript
import bHtml from 'b-html';

bHtml('<p') === '<p></p>';
```
