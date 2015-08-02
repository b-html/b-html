assert = require 'power-assert'
bHtml = require './'

describe 'Attribute', ->
  context 'with value', ->
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

  context 'without value', ->
    it 'works', ->
      html = bHtml '''
        </input
          @type checkbox
          @checked
      '''
      assert html is '''
        <input
          type="checkbox"
          checked
          />
      '''

      html = bHtml '''
        <p
          @data-foo
      '''
      assert html is '''
        <p
          data-foo
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
      assert.throws f, /attribute must have a parent/
