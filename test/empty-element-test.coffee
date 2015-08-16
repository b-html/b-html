assert = require 'power-assert'
bHtml = require './'

describe 'EmptyElement (</)', ->
  it 'works', ->
    source = '''
      </img
    '''
    assert bHtml(source, demo: true) is '<img />'

    source = '''
      </img
        @src /images/sample.png
    '''
    assert bHtml(source) is '<img src="/images/sample.png" />'
    assert bHtml(source, demo: true) is '''
      <img
        src="/images/sample.png"
        />
    '''

    source = '''
      </img
        @alt sample
        @src /images/sample.png
    '''
    assert bHtml(source) is '<img alt="sample" src="/images/sample.png" />'
    assert bHtml(source, demo: true) is '''
      <img
        alt="sample"
        src="/images/sample.png"
        />
    '''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          </img
              </img
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          </img
            </img
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'empty element must not have a child'
        true
