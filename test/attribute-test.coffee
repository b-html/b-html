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

      source = '<p\n  @class ' # with trailing space
      assert bHtml(source) is '<p class=""></p>'
      assert bHtml(source, demo: true) is '''
        <p
          class=""
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
      f = ->
        bHtml '''
          <p
              @class foo
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      # NOTE: attribute doesn't have a child
      f = ->
        bHtml '''
          <p
            @class foo
              @id bar
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 3
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          <p
          @class foo
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 1
        assert lineNumber is 2
        assert message is 'attribute must have a parent'
        true

      f = ->
        bHtml '''
          <p
            @ invalid
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'invalid attribute'
        true
