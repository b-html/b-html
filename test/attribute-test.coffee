assert = require 'power-assert'
bHtml = require './'

describe 'Attribute (@)', ->
  context 'with value', ->
    it 'works', ->
      source = '''
        <p
          @class foo
      '''
      assert bHtml(source) is '<p class="foo"></p>'
      assert bHtml(source, demo: true) is '''
        <p
          class="foo"
          >
        </p>
      '''

      source = '''
        <p
          @class foo
          @id bar
      '''
      assert bHtml(source) is '<p class="foo" id="bar"></p>'
      assert bHtml(source, demo: true) is '''
        <p
          class="foo"
          id="bar"
          >
        </p>
      '''

  context 'without value', ->
    it 'works', ->
      source = '''
        </input
          @type checkbox
          @checked
      '''
      assert bHtml(source) is '<input type="checkbox" checked />'
      assert bHtml(source, demo: true) is '''
        <input
          type="checkbox"
          checked
          />
      '''

      source = '''
        <p
          @data-foo
      '''
      assert bHtml(source) is '<p data-foo></p>'
      assert bHtml(source, demo: true) is '''
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
