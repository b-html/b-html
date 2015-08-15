assert = require 'power-assert'
bHtml = require './'

describe 'Doctype (<!doctype)', ->
  it 'works', ->
    source = '''
      <!doctype html
    '''
    assert bHtml(source, demo: true) is '<!DOCTYPE html>'

    source = '''
      <!DOCTYPE html
    '''
    assert bHtml(source, demo: true) is '<!DOCTYPE html>'

    source = '''
      <!doctype html
    '''
    assert bHtml(source) is '<!DOCTYPE html>'

    source = '''
      <!DOCTYPE html
    '''
    assert bHtml(source) is '<!DOCTYPE html>'

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <!doctype html
              <!doctype html
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 4
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          <!doctype html
            <!doctype html
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 2
        assert lineNumber is 2
        assert message is 'doctype must not have a child'
        true
