assert = require 'power-assert'
bHtml = require './'

describe 'HtmlComment (<!--)', ->
  it 'works', ->
    source = '''
      <!--xyz
    '''
    assert bHtml(source, demo: true) is '<!--xyz-->'

    source = '''
      <!--xyz
    '''
    assert bHtml(source) is '<!--xyz-->'

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <!--xyz
              <!--xyz
        '''
      assert.throws f, /too deep indentation/

      f = ->
        bHtml '''
          <!--xyz
            <!--xyz
        '''
      assert.throws f, /html comment must not have a child/
