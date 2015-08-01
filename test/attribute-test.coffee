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
      # NOTE: too deep indentation
      # f = ->
      #   bHtml '''
      #     <p
      #       @class foo
      #         @class bar
      #   '''
      # assert.throws f, /attribute doesn't have a child/

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
      assert.throws f, /attribute requires a parent/
