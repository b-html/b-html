assert = require 'power-assert'
bHtml = require './'

describe 'Comment (<!--)', ->
  context '1', ->
    it 'works', ->
      source = '''
        <!--xyz
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'comment'
        assert nodes[0].value is 'xyz'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<!--xyz-->'
      assert bHtml(source, format: 'demo') is '<!--xyz-->'

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <!--xyz
              <!--xyz
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          <!--xyz
            <!--xyz
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'comment must not have a child'
        true
