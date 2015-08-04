assert = require 'power-assert'
bHtml = require './'

describe 'NewLineText', ->
  it 'works', ->
    source = '''
      |text
    '''
    assert bHtml(source) is '\ntext'
    assert bHtml(source, demo: true) is '''
      text
    '''

    source = '''
      |line1
      |line2
    '''
    assert bHtml(source) is '\nline1\nline2'
    assert bHtml(source, demo: true) is '''
      line1
      line2
    '''

    source = '''
      <p
        |text
    '''
    assert bHtml(source) is '<p>\ntext</p>'
    assert bHtml(source, demo: true) is '''
      <p>
        text
      </p>
    '''

    source = '''
      <p
        |line1
        |line2
    '''
    assert bHtml(source) is '<p>\nline1\nline2</p>'
    assert bHtml(source, demo: true) is '''
      <p>
        line1
        line2
      </p>
    '''

    source = '''
      <p
        |line1
        |
        |line3
    '''
    assert bHtml(source) is '<p>\nline1\n\nline3</p>'
    # NOTE: prevent to remove trailing spaces
    assert bHtml(source, demo: true) is '<p>\n  line1\n  \n  line3\n</p>'

    # NOTE: escape attribute
    source = '''
      |@text
    '''
    assert bHtml(source) is '\n@text'
    assert bHtml(source, demo: true) is '''
      @text
    '''

    # NOTE: escape element
    source = '''
      |<text
    '''
    assert bHtml(source) is '\n<text'
    assert bHtml(source, demo: true) is '''
      <text
    '''

    # NOTE: escape text
    source = '''
      |>text
    '''
    assert bHtml(source) is '\n>text'
    assert bHtml(source, demo: true) is '''
      >text
    '''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          |line1
            |line2
        '''
      assert.throws f, /text must not have a child/

      f = ->
        bHtml '''
          |line1
              |line2
        '''
      assert.throws f, /too deep indentation/
