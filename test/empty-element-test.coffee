assert = require 'power-assert'
bHtml = require './'

describe 'EmptyElement', ->
  it 'works', ->
    html = bHtml '''
      </img
    '''
    assert html is '<img />'

    html = bHtml '''
      </img
        @src /images/sample.png
    '''
    assert html is '''
      <img
        src="/images/sample.png"
        />
    '''

    html = bHtml '''
      </img
        @alt sample image
        @src /images/sample.png
    '''
    assert html is '''
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
