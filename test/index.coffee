assert = require 'power-assert'
bHtml = require '../src/'

describe 'index', ->
  describe 'Element', ->
    it 'works', ->
      html = bHtml '''
        <p
      '''
      assert html is '''
        <p>
        </p>
      '''

      html = bHtml '''
        <p
        <p
      '''
      assert html is '''
        <p>
        </p>
        <p>
        </p>
      '''

      html = bHtml '''
        <p
          <p
      '''
      assert html is '''
        <p>
          <p>
          </p>
        </p>
      '''

      html = bHtml '''
        <p
          <p
          <p
      '''
      assert html is '''
        <p>
          <p>
          </p>
          <p>
          </p>
        </p>
      '''

  describe 'Attribute', ->
    it 'works', ->
      html = bHtml '''
        <p
          @class foo
      '''
      assert html is '''
        <p
          class="foo"
          >
        </p>
      '''

      html = bHtml '''
        <p
          @class foo
          @id bar
      '''
      assert html is '''
        <p
          class="foo"
          id="bar"
          >
        </p>
      '''

      # TODO: should be thrown Error ?
      html = bHtml '''
        <p
          @class foo
            @id bar
      '''

  describe 'EmptyElement', ->
    it 'works', ->
      html = bHtml '''
        </img
      '''
      assert html is '<img />'

      html = bHtml '''
        </img
          @src /images/sample.png
      '''
      assert html is '''
        <img
          src="/images/sample.png"
          />
      '''

      html = bHtml '''
        </img
          @alt sample image
          @src /images/sample.png
      '''
      assert html is '''
        <img
          alt="sample image"
          src="/images/sample.png"
          />
      '''

  describe 'Comment', ->
    it 'works', ->
      html = bHtml '''
        <!DOCTYPE html>
      '''
      assert html is '''
        <!DOCTYPE html>
      '''

      html = bHtml '''
        <!-- abc -->
      '''
      assert html is '''
        <!-- abc -->
      '''

      html = bHtml '''
        <!-- abc -->
        <!-- def -->
      '''
      assert html is '''
        <!-- abc -->
        <!-- def -->
      '''

      html = bHtml '''
        <!-- abc -->
          <!-- def -->
      '''
      assert html is '''
        <!-- abc -->
          <!-- def -->
      '''

      html = bHtml '''
        <!-- abc -->
          <!-- def -->
          <!-- ghi -->
      '''
      assert html is '''
        <!-- abc -->
          <!-- def -->
          <!-- ghi -->
      '''

  describe 'Text', ->
    describe '>', ->
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
