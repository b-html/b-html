assert = require 'power-assert'
bHtml = require './'

describe 'BHtmlComment (<-)', ->
  it 'works', ->
    source = '''
      <-
    '''
    assert bHtml(source) is ''
    assert bHtml(source, demo: true) is ''

    source = '''
      <- foo
    '''
    assert bHtml(source) is ''
    assert bHtml(source, demo: true) is ''

    source = '''
      <- foo
      <- bar
    '''
    assert bHtml(source) is ''
    assert bHtml(source, demo: true) is ''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <- abc
              <- def
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 4
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          <- abc
            <- def
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 2
        assert lineNumber is 2
        assert message is 'b-html comment must not have a child'
        true
