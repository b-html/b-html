assert = require 'power-assert'
bHtml = require './'

describe 'index README example', ->
  it 'works', ->
    source = '''
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
    '''
    assert bHtml(source) is '<!DOCTYPE html><html lang="en"><head><meta charset="utf-8" /><title>TITLE</title></head><body><!--comment--><h1 class="title">HEADLINE</h1><p>Hello, b-html!@bouzuya<img alt="sample image" src="/images/sample.png" /></p></body></html>'
    assert bHtml(source, format: 'demo') is '''
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
    '''
    format = (nodes, options) ->
      assert nodes.length is 2
      assert nodes[0].type is 'doctype'
      assert nodes[0].value is 'html'
      assert nodes[1].type is 'element'
      assert nodes[1].name is 'html'
      assert nodes[1].attributes.length is 1
      assert nodes[1].attributes[0].type is 'attribute'
      assert nodes[1].attributes[0].name is 'lang'
      assert nodes[1].attributes[0].value is 'en'
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
      assert head.children[0].attributes[0].value is 'utf-8'
      assert head.children[0].children.length is 0
      assert head.children[1].name is 'title'
      assert head.children[1].attributes.length is 0
      assert head.children[1].children.length is 1
      assert head.children[1].children[0].type is 'text'
      assert head.children[1].children[0].value is 'TITLE'
      body = nodes[1].children[1]
      assert body.type is 'element'
      assert body.name is 'body'
      assert body.attributes.length is 0
      assert body.children.length is 3
      assert body.children[0].type is 'comment'
      assert body.children[0].value is 'comment'
      assert body.children[1].type is 'element'
      assert body.children[1].name is 'h1'
      assert body.children[1].attributes.length is 1
      assert body.children[1].attributes[0].type is 'attribute'
      assert body.children[1].attributes[0].name is 'class'
      assert body.children[1].attributes[0].value is 'title'
      assert body.children[1].children.length is 1
      assert body.children[1].children[0].type is 'text'
      assert body.children[1].children[0].value is 'HEADLINE'
      assert body.children[2].type is 'element'
      assert body.children[2].name is 'p'
      assert body.children[2].attributes.length is 0
      assert body.children[2].children.length is 3
      assert body.children[2].children[0].type is 'text'
      assert body.children[2].children[0].value is 'Hello, b-html!'
      assert body.children[2].children[1].type is 'text'
      assert body.children[2].children[1].value is '@bouzuya'
      img = body.children[2].children[2]
      assert img.type is 'empty element'
      assert img.name is 'img'
      assert img.attributes.length is 2
      assert img.attributes[0].type is 'attribute'
      assert img.attributes[0].name is 'alt'
      assert img.attributes[0].value is 'sample image'
      assert img.attributes[1].type is 'attribute'
      assert img.attributes[1].name is 'src'
      assert img.attributes[1].value is '/images/sample.png'
      assert img.children.length is 0
      assert.deepEqual options, { format }
    bHtml source, { format }
