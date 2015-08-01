assert = require 'power-assert'
bHtml = require './'

describe 'index', ->
  it 'works', ->
    html = bHtml '''
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
    '''
    assert html is '''
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
    '''
