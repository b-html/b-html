assert = require 'power-assert'
bHtml = require './'

describe 'Element', ->
  it 'works', ->
    source = '''
      <p
    '''
    assert bHtml(source, demo: true) is '''
      <p>
      </p>
    '''

    source = '''
      <p
      <p
    '''
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
      assert.throws f, /too deep indentation/
