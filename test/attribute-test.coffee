assert = require 'power-assert'
bHtml = require './'

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

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <p
              @class foo
        '''
      assert.throws f, /too deep indentation/

      f = ->
        bHtml '''
          <p
            @class foo
              @id bar
        '''
      assert.throws f, /too deep indentation/

      f = ->
        bHtml '''
          <p
          @class foo
        '''
      assert.throws f, /attribute requires an element/
