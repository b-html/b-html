assert = require 'power-assert'
bHtml = require './'

describe 'Comment', ->
  it 'works', ->
    html = bHtml '''
      <! foo
    '''
    assert html is ''

    html = bHtml '''
      <! foo
      <! bar
    '''
    assert html is ''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <!-- hoge -->
              <!-- hoge -->
        '''
      assert.throws f, /too deep indentation/
