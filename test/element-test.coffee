assert = require 'power-assert'
bHtml = require './'

describe 'Element (<)', ->
  context '1', ->
    it 'works', ->
      source = '''
        <p
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p></p>'
      assert bHtml(source, format: 'demo') is '''
        <p>
        </p>
      '''

  context '2', ->
    it 'works', ->
      source = '''
        <p
        <p
      '''
      format = (nodes, options) ->
        assert nodes.length is 2
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 0
        assert nodes[1].type is 'element'
        assert nodes[1].name is 'p'
        assert nodes[1].attributes.length is 0
        assert nodes[1].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p></p><p></p>'
      assert bHtml(source, format: 'demo') is '''
        <p>
        </p>
        <p>
        </p>
      '''

  context '3', ->
    it 'works', ->
      source = '''
        <p
          <p
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 1
        assert nodes[0].children[0].type is 'element'
        assert nodes[0].children[0].name is 'p'
        assert nodes[0].children[0].attributes.length is 0
        assert nodes[0].children[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p><p></p></p>'
      assert bHtml(source, format: 'demo') is '''
        <p>
          <p>
          </p>
        </p>
      '''

  context '4', ->
    it 'works', ->
      source = '''
        <p
          <p
          <p
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'element'
        assert nodes[0].name is 'p'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 2
        assert nodes[0].children[0].type is 'element'
        assert nodes[0].children[0].name is 'p'
        assert nodes[0].children[0].attributes.length is 0
        assert nodes[0].children[0].children.length is 0
        assert nodes[0].children[1].type is 'element'
        assert nodes[0].children[1].name is 'p'
        assert nodes[0].children[1].attributes.length is 0
        assert nodes[0].children[1].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<p><p></p><p></p></p>'
      assert bHtml(source, format: 'demo') is '''
        <p>
          <p>
          </p>
          <p>
          </p>
        </p>
      '''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <p
              <p
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          <p
            < p
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'invalid element'
        true
