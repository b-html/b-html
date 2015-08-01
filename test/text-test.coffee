assert = require 'power-assert'
bHtml = require '../src/'

describe 'Text', ->
  context '>', ->
    it 'works', ->
      html = bHtml '''
        >text
      '''
      assert html is '''
        text
      '''

      html = bHtml '''
        >line1
        >line2
      '''
      assert html is '''
        line1
        line2
      '''

      html = bHtml '''
        <p
          >text
      '''
      assert html is '''
        <p>
          text
        </p>
      '''

      html = bHtml '''
        <p
          >line1
          >line2
      '''
      assert html is '''
        <p>
          line1
          line2
        </p>
      '''

      html = bHtml '''
        <p
          >line1
          >
          >line3
      '''
      # NOTE: prevent to remove trailing spaces
      assert html is '<p>\n  line1\n  \n  line3\n</p>'

      # NOTE: escape attribute
      html = bHtml '''
        >@text
      '''
      assert html is '''
        @text
      '''

      # NOTE: escape element
      html = bHtml '''
        ><text
      '''
      assert html is '''
        <text
      '''

      # NOTE: escape text
      html = bHtml '''
        >>text
      '''
      assert html is '''
        >text
      '''

  context '(default)', ->
    it 'works', ->
      html = bHtml '\n'
      assert html is ''

      html = bHtml '''
        text
      '''
      assert html is '''
        text
      '''

      html = bHtml '''
        line1
        line2
      '''
      assert html is '''
        line1
        line2
      '''

      html = bHtml '''
        <p
          text
      '''
      assert html is '''
        <p>
          text
        </p>
      '''

      html = bHtml '''
        <p
          line1
          line2
      '''
      assert html is '''
        <p>
          line1
          line2
        </p>
      '''

      # NOTE: prevent to remove trailing space
      html = bHtml '<p\n  line1\n  \n  line3'
      assert html is '<p>\n  line1\n  \n  line3\n</p>'
