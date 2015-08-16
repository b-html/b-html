assert = require 'power-assert'
bHtml = require './'

describe 'Element (<)', ->
  it 'works', ->
    source = '''
      <p
    '''
    assert bHtml(source) is '<p></p>'
    assert bHtml(source, demo: true) is '''
      <p>
      </p>
    '''

    source = '''
      <p
      <p
    '''
    assert bHtml(source) is '<p></p><p></p>'
    assert bHtml(source, demo: true) is '''
      <p>
      </p>
      <p>
      </p>
    '''

    source = '''
      <p
        <p
    '''
    assert bHtml(source) is '<p><p></p></p>'
    assert bHtml(source, demo: true) is '''
      <p>
        <p>
        </p>
      </p>
    '''

    source = '''
      <p
        <p
        <p
    '''
    assert bHtml(source) is '<p><p></p><p></p></p>'
    assert bHtml(source, demo: true) is '''
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
