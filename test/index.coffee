assert = require 'power-assert'
bHtml = require '../src/'

describe 'index', ->
  it 'works', ->
    html = bHtml '\n'
    assert html is ''

    html = bHtml '<p\n'
    assert html is '<p></p>'

    html = bHtml '''
      <p
    '''
    assert html is '<p></p>'

    html = bHtml '''
      <p
      <p
    '''
    assert html is '<p></p><p></p>'

    html = bHtml '''
      <p
        <p
    '''
    assert html is '<p><p></p></p>'

    html = bHtml '''
      <p
        @class foo
    '''
    assert html is '<p class="foo"></p>'

    html = bHtml '''
      <p
        @class foo
        @id bar
    '''
    assert html is '<p class="foo" id="bar"></p>'

    # TODO:
    html = bHtml '''
      <p
        @class foo
          @id bar
    '''

    html = bHtml '''
      <p
        >content
    '''
    assert html is '<p>content</p>'

    html = bHtml '''
      <p
        >@content
    '''
    assert html is '<p>@content</p>'

    html = bHtml '''
      <p
        >line1
        >line2
    '''
    assert html is '<p>line1line2</p>'

    html = bHtml '''
      <p
        content
    '''
    assert html is '<p>content</p>'

    html = bHtml '''
      <p
        line1
        line2
    '''
    assert html is '<p>line1line2</p>'

    html = bHtml '''
      <p
        line1
        <span
          line2
    '''
    assert html is '<p>line1<span>line2</span></p>'

    html = bHtml '''
      <div
        <h1
          @a v
          t
        <p
          c
    '''
    assert html is '<div><h1 a="v">t</h1><p>c</p></div>'

    html = bHtml '''
      </img
    '''
    assert html is '<img />'

    html = bHtml '''
      <!DOCTYPE html>
    '''
    assert html is '<!DOCTYPE html>'

    html = bHtml '''
      <!-- abc -->
    '''
    assert html is '<!-- abc -->'
