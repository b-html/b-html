assert = require 'power-assert'
bHtml = require './'

describe 'Comment', ->
  it 'works', ->
    source = '''
      <!
    '''
    assert bHtml(source) is ''
    assert bHtml(source, demo: true) is ''

    source = '''
      <! foo
    '''
    assert bHtml(source) is ''
    assert bHtml(source, demo: true) is ''

    source = '''
      <! foo
      <! bar
    '''
    assert bHtml(source) is ''
    assert bHtml(source, demo: true) is ''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <! abc
            <! def
        '''
      assert.throws f, /comment must not have a child/

      f = ->
        bHtml '''
          <!-- hoge -->
              <!-- hoge -->
        '''
      assert.throws f, /too deep indentation/
