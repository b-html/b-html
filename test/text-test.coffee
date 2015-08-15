assert = require 'power-assert'
bHtml = require './'

describe 'Text (>)', ->
  it 'works', ->
    source = '''
      >text
    '''
    assert bHtml(source) is 'text'
    assert bHtml(source, demo: true) is '''
      text
    '''

    source = '''
      >line1
      >line2
    '''
    assert bHtml(source) is 'line1line2'
    assert bHtml(source, demo: true) is '''
      line1
      line2
    '''

    source = '''
      <p
        >text
    '''
    assert bHtml(source) is '<p>text</p>'
    assert bHtml(source, demo: true) is '''
      <p>
        text
      </p>
    '''

    source = '''
      <p
        >line1
        >line2
    '''
    assert bHtml(source) is '<p>line1line2</p>'
    assert bHtml(source, demo: true) is '''
      <p>
        line1
        line2
      </p>
    '''

    source = '''
      <p
        >line1
        >
        >line3
    '''
    assert bHtml(source) is '<p>line1line3</p>'
    # NOTE: prevent to remove trailing spaces
    assert bHtml(source, demo: true) is '<p>\n  line1\n  \n  line3\n</p>'

    # NOTE: escape attribute
    source = '''
      >@text
    '''
    assert bHtml(source) is '@text'
    assert bHtml(source, demo: true) is '''
      @text
    '''

    # NOTE: escape element
    source = '''
      ><text
    '''
    assert bHtml(source) is '<text'
    assert bHtml(source, demo: true) is '''
      <text
    '''

    # NOTE: escape text
    source = '''
      >>text
    '''
    assert bHtml(source) is '>text'
    assert bHtml(source, demo: true) is '''
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
        assert columnNumber is 4
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          >line1
            >line2
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 2
        assert lineNumber is 2
        assert message is 'text must not have a child'
        true
