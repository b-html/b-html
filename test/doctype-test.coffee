assert = require 'power-assert'
bHtml = require './'

describe 'Doctype (<!doctype)', ->
  it 'works', ->
    source = '''
      <!doctype html
    '''
    assert bHtml(source, demo: true) is '<!DOCTYPE html>'
    assert bHtml(source) is '<!DOCTYPE html>'

    source = '''
      <!DOCTYPE html
    '''
    assert bHtml(source, demo: true) is '<!DOCTYPE html>'
    assert bHtml(source) is '<!DOCTYPE html>'

    source = '''
      <!doctype html 5
    '''
    assert bHtml(source, demo: true) is '<!DOCTYPE html>'
    assert bHtml(source) is '<!DOCTYPE html>'

    source = '''
      <!doctype html 4.01 strict
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01//EN"
      "http://www.w3.org/TR/html4/strict.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01//EN"
      "http://www.w3.org/TR/html4/strict.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype html 4.01 transitional
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Transitional//EN"
      "http://www.w3.org/TR/html4/loose.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Transitional//EN"
      "http://www.w3.org/TR/html4/loose.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype html 4.01 frameset
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Frameset//EN"
      "http://www.w3.org/TR/html4/frameset.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Frameset//EN"
      "http://www.w3.org/TR/html4/frameset.dtd">
    '''.split(/\n/).join(' ')


    source = '''
      <!doctype html strict
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01//EN"
      "http://www.w3.org/TR/html4/strict.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01//EN"
      "http://www.w3.org/TR/html4/strict.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype html transitional
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Transitional//EN"
      "http://www.w3.org/TR/html4/loose.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Transitional//EN"
      "http://www.w3.org/TR/html4/loose.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype html frameset
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Frameset//EN"
      "http://www.w3.org/TR/html4/frameset.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE HTML PUBLIC
      "-//W3C//DTD HTML 4.01 Frameset//EN"
      "http://www.w3.org/TR/html4/frameset.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml 1.0 strict
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml 1.0 transitional
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml 1.0 frameset
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Frameset//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Frameset//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml strict
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml transitional
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml frameset
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Frameset//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Frameset//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml 1.1
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.1//EN"
      "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.1//EN"
      "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml basic 1.0
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML Basic 1.0//EN"
      "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic10.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML Basic 1.0//EN"
      "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic10.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml basic 1.1
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML Basic 1.1//EN"
      "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML Basic 1.1//EN"
      "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml basic
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML Basic 1.1//EN"
      "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML Basic 1.1//EN"
      "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml mobile 1.0
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.0//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile10.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.0//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile10.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml mobile 1.1
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml mobile 1.2
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype xhtml mobile
    '''
    assert bHtml(source, demo: true) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
    '''.split(/\n/).join(' ')
    assert bHtml(source) is '''
      <!DOCTYPE html PUBLIC
      "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
      "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
    '''.split(/\n/).join(' ')

    source = '''
      <!doctype html PUBLIC hoge
    '''
    assert bHtml(source, demo: true) is '<!DOCTYPE html PUBLIC hoge>'
    assert bHtml(source) is '<!DOCTYPE html PUBLIC hoge>'

    source = '''
      <!doctype html SYSTEM fuga
    '''
    assert bHtml(source, demo: true) is '<!DOCTYPE html SYSTEM fuga>'
    assert bHtml(source) is '<!DOCTYPE html SYSTEM fuga>'

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          <!doctype html
              <!doctype html
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          <!doctype html
            <!doctype html
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'doctype must not have a child'
        true

      f = ->
        bHtml '''
          <!doctype foo
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 1
        assert lineNumber is 1
        assert message is 'invalid doctype'
        true

      f = ->
        bHtml '''
          <!doctype html bar
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 1
        assert lineNumber is 1
        assert message is 'invalid doctype'
        true

      f = ->
        bHtml '''
          <!doctype xhtml baz
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 1
        assert lineNumber is 1
        assert message is 'invalid doctype'
        true
