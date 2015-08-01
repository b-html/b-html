assert = require 'power-assert'
bHtml = require '../src/'

describe 'Attribute', ->
  it 'works', ->
    html = bHtml '''
      <p
        @class foo
    '''
    assert html is '''
      <p
        class="foo"
        >
      </p>
    '''

    html = bHtml '''
      <p
        @class foo
        @id bar
    '''
    assert html is '''
      <p
        class="foo"
        id="bar"
        >
      </p>
    '''

    # TODO: should be thrown Error ?
    html = bHtml '''
      <p
        @class foo
          @id bar
    '''
