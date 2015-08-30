assert = require 'power-assert'
bHtml = require './'

describe '"attribute" (@)', ->
  context '1', ->
    it 'works', ->
      source = '''
        <p
          @class foo
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 1
        assert nodes[0].attributes[0].type is 'attribute'
        assert nodes[0].attributes[0].name is 'class'
        assert nodes[0].attributes[0].value is 'foo'
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p class="foo"></p>'
      assert bHtml(source, format: 'demo') is '''
        <p
          class="foo"
          >
        </p>
      '''

  context '2', ->
    it 'works', ->
      source = '''
        <p
          @class foo
          @id bar
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 2
        assert nodes[0].attributes[0].type is 'attribute'
        assert nodes[0].attributes[0].name is 'class'
        assert nodes[0].attributes[0].value is 'foo'
        assert nodes[0].attributes[1].type is 'attribute'
        assert nodes[0].attributes[1].name is 'id'
        assert nodes[0].attributes[1].value is 'bar'
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p class="foo" id="bar"></p>'
      assert bHtml(source, format: 'demo') is '''
        <p
          class="foo"
          id="bar"
          >
        </p>
      '''

  context '3', ->
    it 'works', ->
      source = '<p\n  @class ' # with trailing space
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 1
        assert nodes[0].attributes[0].type is 'attribute'
        assert nodes[0].attributes[0].name is 'class'
        assert nodes[0].attributes[0].value is ''
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p class=""></p>'
      assert bHtml(source, format: 'demo') is '''
        <p
          class=""
          >
        </p>
      '''

  context '4', ->
    it 'works', ->
      source = '''
        </input
          @type checkbox
          @checked
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'empty element'
        assert nodes[0].name is 'input'
        assert nodes[0].attributes.length is 2
        assert nodes[0].attributes[0].type is 'attribute'
        assert nodes[0].attributes[0].name is 'type'
        assert nodes[0].attributes[0].value is 'checkbox'
        assert nodes[0].attributes[1].type is 'attribute'
        assert nodes[0].attributes[1].name is 'checked'
        assert nodes[0].attributes[1].value is undefined
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<input type="checkbox" checked />'
      assert bHtml(source, format: 'demo') is '''
        <input
          type="checkbox"
          checked
          />
      '''

  context '5', ->
    it 'works', ->
      source = '''
        <p
          @data-foo
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 1
        assert nodes[0].attributes[0].type is 'attribute'
        assert nodes[0].attributes[0].name is 'data-foo'
        assert nodes[0].attributes[0].value is undefined
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p data-foo></p>'
      assert bHtml(source, format: 'demo') is '''
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
