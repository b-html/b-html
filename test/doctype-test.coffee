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
      assert.throws f, /too deep indentation/

      f = ->
        bHtml '''
          <!doctype html
            <!doctype html
        '''
      assert.throws f, /doctype must not have a child/
