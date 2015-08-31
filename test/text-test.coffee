assert = require 'power-assert'
bHtml = require './'

describe 'Text (>)', ->
  context '1', ->
    it 'works', ->
      source = '''
        >text
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'text'
        assert nodes[0].value is 'text'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is 'text'
      assert bHtml(source, format: 'demo') is '''
        text
      '''

  context '2', ->
    it 'works', ->
      source = '''
        >line1
        >line2
      '''
      format = (nodes, options) ->
        assert nodes.length is 2
        assert nodes[0].type is 'text'
        assert nodes[0].value is 'line1'
        assert nodes[1].type is 'text'
        assert nodes[1].value is 'line2'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is 'line1line2'
      assert bHtml(source, format: 'demo') is '''
        line1
        line2
      '''

  context '3', ->
    it 'works', ->
      source = '''
        <p
          >text
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 1
        assert nodes[0].children[0].type is 'text'
        assert nodes[0].children[0].value is 'text'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p>text</p>'
      assert bHtml(source, format: 'demo') is '''
        <p>
          text
        </p>
      '''

  context '4', ->
    it 'works', ->
      source = '''
        <p
          >line1
          >line2
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 2
        assert nodes[0].children[0].type is 'text'
        assert nodes[0].children[0].value is 'line1'
        assert nodes[0].children[1].type is 'text'
        assert nodes[0].children[1].value is 'line2'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p>line1line2</p>'
      assert bHtml(source, format: 'demo') is '''
        <p>
          line1
          line2
        </p>
      '''

  context '5', ->
    it 'works', ->
      source = '''
        <p
          >line1
          >
          >line3
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 3
        assert nodes[0].children[0].type is 'text'
        assert nodes[0].children[0].value is 'line1'
        assert nodes[0].children[1].type is 'text'
        assert nodes[0].children[1].value is ''
        assert nodes[0].children[2].type is 'text'
        assert nodes[0].children[2].value is 'line3'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p>line1line3</p>'
      # NOTE: prevent to remove trailing spaces
      assert bHtml(source, format: 'demo') is '<p>\n  line1\n  \n  line3\n</p>'

  context '6', ->
    it 'works', ->
      # NOTE: escape attribute
      source = '''
        >@text
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'text'
        assert nodes[0].value is '@text'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '@text'
      assert bHtml(source, format: 'demo') is '''
        @text
      '''

  context '7', ->
    it 'works', ->
      # NOTE: escape element
      source = '''
        ><text
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'text'
        assert nodes[0].value is '<text'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<text'
      assert bHtml(source, format: 'demo') is '''
        <text
      '''

  context '8', ->
    it 'works', ->
      # NOTE: escape text
      source = '''
        >>text
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'text'
        assert nodes[0].value is '>text'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '>text'
      assert bHtml(source, format: 'demo') is '''
        >text
      '''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          >line1
              >line2
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          >line1
            >line2
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'text must not have a child'
        true
