assert = require 'power-assert'
bHtml = require './'

describe 'Element', ->
  it 'works', ->
    html = bHtml '''
      <p
    '''
    assert html is '''
      <p>
      </p>
    '''

    html = bHtml '''
      <p
      <p
    '''
    assert html is '''
      <p>
      </p>
      <p>
      </p>
    '''

    html = bHtml '''
      <p
        <p
    '''
    assert html is '''
      <p>
        <p>
        </p>
      </p>
    '''

    html = bHtml '''
      <p
        <p
        <p
    '''
    assert html is '''
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
      assert.throws f, /too deep indentation/
