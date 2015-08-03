assert = require 'power-assert'
bHtml = require './'

describe 'Text', ->
  context '>', ->
    it 'works', ->
      source = '''
        >text
      '''
      assert bHtml(source, demo: true) is '''
        text
      '''

      source = '''
        >line1
        >line2
      '''
      assert bHtml(source, demo: true) is '''
        line1
        line2
      '''

      source = '''
        <p
          >text
      '''
      assert bHtml(source, demo: true) is '''
        <p>
          text
        </p>
      '''

      source = '''
        <p
          >line1
          >line2
      '''
      assert bHtml(source, demo: true) is '''
        <p>
          line1
          line2
        </p>
      '''

      source = '''
        <p
          >line1
          >
          >line3
      '''
      # NOTE: prevent to remove trailing spaces
      assert bHtml(source, demo: true) is '<p>\n  line1\n  \n  line3\n</p>'

      # NOTE: escape attribute
      source = '''
        >@text
      '''
      assert bHtml(source, demo: true) is '''
        @text
      '''

      # NOTE: escape element
      source = '''
        ><text
      '''
      assert bHtml(source, demo: true) is '''
        <text
      '''

      # NOTE: escape text
      source = '''
        >>text
      '''
      assert bHtml(source, demo: true) is '''
        >text
      '''

  context '(default)', ->
    it 'works', ->
      source = '\n'
      assert bHtml(source, demo: true) is ''

      source = '''
        text
      '''
      assert bHtml(source, demo: true) is '''
        text
      '''

      source = '''
        line1
        line2
      '''
      assert bHtml(source, demo: true) is '''
        line1
        line2
      '''

      source = '''
        <p
          text
      '''
      assert bHtml(source, demo: true) is '''
        <p>
          text
        </p>
      '''

      source = '''
        <p
          line1
          line2
      '''
      assert bHtml(source, demo: true) is '''
        <p>
          line1
          line2
        </p>
      '''

      # NOTE: prevent to remove trailing space
      source = '<p\n  line1\n  \n  line3'
      assert bHtml(source, demo: true) is '<p>\n  line1\n  \n  line3\n</p>'

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          line1
            line2
        '''
      assert.throws f, /text must not have a child/

      f = ->
        bHtml '''
          line1
              line2
        '''
      assert.throws f, /too deep indentation/
