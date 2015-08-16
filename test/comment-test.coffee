assert = require 'power-assert'
bHtml = require './'

describe 'Comment (<!--)', ->
  it 'works', ->
    source = '''
      <!--xyz
    '''
    assert bHtml(source, demo: true) is '<!--xyz-->'

    source = '''
      <!--xyz
    '''
    assert bHtml(source) is '<!--xyz-->'

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <!--xyz
              <!--xyz
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 4
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          <!--xyz
            <!--xyz
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 2
        assert lineNumber is 2
        assert message is 'comment must not have a child'
        true
