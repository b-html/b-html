assert = require 'power-assert'
bHtml = require './'

describe 'index README example', ->
  it 'works', ->
    source = '''
      ><!DOCTYPE html>
      <html
        @lang en
        <head
          </meta
            @charset utf-8
          <title
            TITLE
        <body
          <- b-html comment
          ><!-- HTML comment -->
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
    assert bHtml(source) is '<!DOCTYPE html><html lang="en"><head><meta charset="utf-8" /><title>TITLE</title></head><body><!-- HTML comment --><h1 class="title">HEADLINE</h1><p>Hello, b-html!@bouzuya<img alt="sample image" src="/images/sample.png" /></p></body></html>'
    assert bHtml(source, demo: true) is '''
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
          <!-- HTML comment -->
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
