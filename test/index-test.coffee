assert = require 'power-assert'
bHtml = require './'

describe 'index README example', ->
  it 'works', ->
    source = '''
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
    '''
    assert bHtml(source) is '<!DOCTYPE html><html><head><meta charset="UTF-8" /><title>b-html example</title></head><body><!--comment example--><p>Hello, b-html!<a href="https://github.com/bouzuya">@bouzuya</a></p></body></html>'
    assert bHtml(source, format: 'demo') is '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta
            charset="UTF-8"
            />
          <title>
            b-html example
          </title>
        </head>
        <body>
          <!--comment example-->
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
    '''
    format = (nodes, options) ->
      assert nodes.length is 2
      assert nodes[0].type is 'doctype'
      assert nodes[0].value is 'html'
      assert nodes[1].type is 'element'
      assert nodes[1].name is 'html'
      assert nodes[1].attributes.length is 0
      assert nodes[1].children.length is 2
      head = nodes[1].children[0]
      assert head.type is 'element'
      assert head.name is 'head'
      assert head.attributes.length is 0
      assert head.children.length is 2
      assert head.children[0].type is 'empty element'
      assert head.children[0].name is 'meta'
      assert head.children[0].attributes.length is 1
      assert head.children[0].attributes[0].type is 'attribute'
      assert head.children[0].attributes[0].name is 'charset'
      assert head.children[0].attributes[0].value is 'UTF-8'
      assert head.children[0].children.length is 0
      assert head.children[1].name is 'title'
      assert head.children[1].attributes.length is 0
      assert head.children[1].children.length is 1
      assert head.children[1].children[0].type is 'text'
      assert head.children[1].children[0].value is 'b-html example'
      body = nodes[1].children[1]
      assert body.type is 'element'
      assert body.name is 'body'
      assert body.attributes.length is 0
      assert body.children.length is 2
      assert body.children[0].type is 'comment'
      assert body.children[0].value is 'comment example'
      assert body.children[1].type is 'element'
      assert body.children[1].name is 'p'
      assert body.children[1].attributes.length is 0
      assert body.children[1].children.length is 2
      assert body.children[1].children[0].type is 'text'
      assert body.children[1].children[0].value is 'Hello, b-html!'
      a = body.children[1].children[1]
      assert a.type is 'element'
      assert a.name is 'a'
      assert a.attributes.length is 1
      assert a.attributes[0].type is 'attribute'
      assert a.attributes[0].name is 'href'
      assert a.attributes[0].value is 'https://github.com/bouzuya'
      assert a.children.length is 1
      assert a.children[0].type is 'text'
      assert a.children[0].value is '@bouzuya'
      assert.deepEqual options, { format }
    bHtml source, { format }
