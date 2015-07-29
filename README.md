# bHTML

bHTML is a little language that compiles into HTML.

## Installation

```
$ npm install b-html
```

## Syntax

bHTML:

```bhtml
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

```
import bhtml from 'bhtml'

bhtml('<p') === '<p></p>'
```
