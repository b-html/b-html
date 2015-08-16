assert = require 'power-assert'
bHtml = require './'

describe 'DefaultText (default)', ->
  it 'works', ->
    source = '\n'
    assert bHtml(source) is ''
    assert bHtml(source, demo: true) is ''

    source = '''
      text
    '''
    assert bHtml(source) is 'text'
    assert bHtml(source, demo: true) is '''
      text
    '''

    source = '''
      line1
      line2
    '''
    assert bHtml(source) is 'line1line2'
    assert bHtml(source, demo: true) is '''
      line1
      line2
    '''

    source = '''
      <p
        text
    '''
    assert bHtml(source) is '<p>text</p>'
    assert bHtml(source, demo: true) is '''
      <p>
        text
      </p>
    '''

    source = '''
      <p
        line1
        line2
    '''
    assert bHtml(source) is '<p>line1line2</p>'
    assert bHtml(source, demo: true) is '''
      <p>
        line1
        line2
      </p>
    '''

    # NOTE: prevent to remove trailing space
    source = '<p\n  line1\n  \n  line3'
    assert bHtml(source) is '<p>line1line3</p>'
    assert bHtml(source, demo: true) is '<p>\n  line1\n  \n  line3\n</p>'

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          line1
              line2
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          line1
            line2
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'default text must not have a child'
        true
