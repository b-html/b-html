assert = require 'power-assert'
bHtml = require './'

describe 'EmptyElement', ->
  it 'works', ->
    source = '''
      </img
    '''
    assert bHtml(source, demo: true) is '<img />'

    source = '''
      </img
        @src /images/sample.png
    '''
    assert bHtml(source, demo: true) is '''
      <img
        src="/images/sample.png"
        />
    '''

    source = '''
      </img
        @alt sample image
        @src /images/sample.png
    '''
    assert bHtml(source, demo: true) is '''
      <img
        alt="sample image"
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
      assert.throws f, /too deep indentation/

      f = ->
        bHtml '''
          </img
            </img
        '''
      assert.throws f, /empty element must not have a child/
