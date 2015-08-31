assert = require 'power-assert'
bHtml = require './'

describe 'Doctype (<!doctype)', ->
  context '1', ->
    it 'works', ->
      source = '''
        <!doctype html
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is 'html'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '<!DOCTYPE html>'
      assert bHtml(source) is '<!DOCTYPE html>'

  context '2', ->
    it 'works', ->
      source = '''
        <!DOCTYPE html
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is 'html'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '<!DOCTYPE html>'
      assert bHtml(source) is '<!DOCTYPE html>'

  context '3', ->
    it 'works', ->
      source = '''
        <!doctype html 5
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is 'html'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '<!DOCTYPE html>'
      assert bHtml(source) is '<!DOCTYPE html>'

  context '4', ->
    it 'works', ->
      source = '''
        <!doctype html 4.01 strict
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          HTML PUBLIC
          "-//W3C//DTD HTML 4.01//EN"
          "http://www.w3.org/TR/html4/strict.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
      '''.split(/\n/).join(' ')

  context '5', ->
    it 'works', ->
      source = '''
        <!doctype html 4.01 transitional
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          HTML PUBLIC
          "-//W3C//DTD HTML 4.01 Transitional//EN"
          "http://www.w3.org/TR/html4/loose.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
      '''.split(/\n/).join(' ')

  context '6', ->
    it 'works', ->
      source = '''
        <!doctype html 4.01 frameset
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          HTML PUBLIC
          "-//W3C//DTD HTML 4.01 Frameset//EN"
          "http://www.w3.org/TR/html4/frameset.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Frameset//EN"
        "http://www.w3.org/TR/html4/frameset.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Frameset//EN"
        "http://www.w3.org/TR/html4/frameset.dtd">
      '''.split(/\n/).join(' ')

  context '7', ->
    it 'works', ->
      source = '''
        <!doctype html strict
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          HTML PUBLIC
          "-//W3C//DTD HTML 4.01//EN"
          "http://www.w3.org/TR/html4/strict.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
      '''.split(/\n/).join(' ')

  context '8', ->
    it 'works', ->
      source = '''
        <!doctype html transitional
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          HTML PUBLIC
          "-//W3C//DTD HTML 4.01 Transitional//EN"
          "http://www.w3.org/TR/html4/loose.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
      '''.split(/\n/).join(' ')

  context '9', ->
    it 'works', ->
      source = '''
        <!doctype html frameset
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          HTML PUBLIC
          "-//W3C//DTD HTML 4.01 Frameset//EN"
          "http://www.w3.org/TR/html4/frameset.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Frameset//EN"
        "http://www.w3.org/TR/html4/frameset.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE HTML PUBLIC
        "-//W3C//DTD HTML 4.01 Frameset//EN"
        "http://www.w3.org/TR/html4/frameset.dtd">
      '''.split(/\n/).join(' ')

  context '10', ->
    it 'works', ->
      source = '''
        <!doctype xhtml 1.0 strict
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML 1.0 Strict//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      '''.split(/\n/).join(' ')

  context '11', ->
    it 'works', ->
      source = '''
        <!doctype xhtml 1.0 transitional
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML 1.0 Transitional//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      '''.split(/\n/).join(' ')

  context '12', ->
    it 'works', ->
      source = '''
        <!doctype xhtml 1.0 frameset
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML 1.0 Frameset//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Frameset//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Frameset//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
      '''.split(/\n/).join(' ')

  context '13', ->
    it 'works', ->
      source = '''
        <!doctype xhtml strict
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML 1.0 Strict//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      '''.split(/\n/).join(' ')

  context '14', ->
    it 'works', ->
      source = '''
        <!doctype xhtml transitional
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML 1.0 Transitional//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      '''.split(/\n/).join(' ')

  context '15', ->
    it 'works', ->
      source = '''
        <!doctype xhtml frameset
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML 1.0 Frameset//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Frameset//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.0 Frameset//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
      '''.split(/\n/).join(' ')

  context '16', ->
    it 'works', ->
      source = '''
        <!doctype xhtml 1.1
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML 1.1//EN"
          "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.1//EN"
        "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML 1.1//EN"
        "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
      '''.split(/\n/).join(' ')

  context '17', ->
    it 'works', ->
      source = '''
        <!doctype xhtml basic 1.0
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML Basic 1.0//EN"
          "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic10.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML Basic 1.0//EN"
        "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic10.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML Basic 1.0//EN"
        "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic10.dtd">
      '''.split(/\n/).join(' ')

  context '18', ->
    it 'works', ->
      source = '''
        <!doctype xhtml basic 1.1
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML Basic 1.1//EN"
          "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML Basic 1.1//EN"
        "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML Basic 1.1//EN"
        "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
      '''.split(/\n/).join(' ')

  context '19', ->
    it 'works', ->
      source = '''
        <!doctype xhtml basic
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//W3C//DTD XHTML Basic 1.1//EN"
          "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML Basic 1.1//EN"
        "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//W3C//DTD XHTML Basic 1.1//EN"
        "http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd">
      '''.split(/\n/).join(' ')

  context '20', ->
    it 'works', ->
      source = '''
        <!doctype xhtml mobile 1.0
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//WAPFORUM//DTD XHTML Mobile 1.0//EN"
          "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile10.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.0//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile10.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.0//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile10.dtd">
      '''.split(/\n/).join(' ')

  context '21', ->
    it 'works', ->
      source = '''
        <!doctype xhtml mobile 1.1
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
          "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
      '''.split(/\n/).join(' ')

  context '22', ->
    it 'works', ->
      source = '''
        <!doctype xhtml mobile 1.2
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
          "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
      '''.split(/\n/).join(' ')

  context '23', ->
    it 'works', ->
      source = '''
        <!doctype xhtml mobile
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is '''
          html PUBLIC
          "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
          "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd"
        '''.split(/\n/).join(' ')
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
      '''.split(/\n/).join(' ')
      assert bHtml(source) is '''
        <!DOCTYPE html PUBLIC
        "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
        "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
      '''.split(/\n/).join(' ')

  context '24', ->
    it 'works', ->
      source = '''
        <!doctype html PUBLIC hoge
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is 'html PUBLIC hoge'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '<!DOCTYPE html PUBLIC hoge>'
      assert bHtml(source) is '<!DOCTYPE html PUBLIC hoge>'

  context '25', ->
    it 'works', ->
      source = '''
        <!doctype html SYSTEM fuga
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'doctype'
        assert nodes[0].value is 'html SYSTEM fuga'
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source, format: 'demo') is '<!DOCTYPE html SYSTEM fuga>'
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
