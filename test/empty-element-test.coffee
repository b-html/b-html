assert = require 'power-assert'
bHtml = require './'

describe 'EmptyElement (</)', ->
  context '1', ->
    it 'works', ->
      source = '''
        </img
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'empty element'
        assert nodes[0].name is 'img'
        assert nodes[0].attributes.length is 0
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<img />'
      assert bHtml(source, format: 'demo') is '<img />'

  context '2', ->
    it 'works', ->
      source = '''
        </img
          @src /images/sample.png
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'empty element'
        assert nodes[0].name is 'img'
        assert nodes[0].attributes.length is 1
        assert nodes[0].attributes[0].type is 'attribute'
        assert nodes[0].attributes[0].name is 'src'
        assert nodes[0].attributes[0].value is '/images/sample.png'
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<img src="/images/sample.png" />'
      assert bHtml(source, format: 'demo') is '''
        <img
          src="/images/sample.png"
          />
      '''

  context '3', ->
    it 'works', ->
      source = '''
        </img
          @alt sample
          @src /images/sample.png
      '''
      format = (nodes, options) ->
        assert nodes.length is 1
        assert nodes[0].type is 'empty element'
        assert nodes[0].name is 'img'
        assert nodes[0].attributes.length is 2
        assert nodes[0].attributes[0].type is 'attribute'
        assert nodes[0].attributes[0].name is 'alt'
        assert nodes[0].attributes[0].value is 'sample'
        assert nodes[0].attributes[1].type is 'attribute'
        assert nodes[0].attributes[1].name is 'src'
        assert nodes[0].attributes[1].value is '/images/sample.png'
        assert nodes[0].children.length is 0
        assert.deepEqual options, { format }
      bHtml source, { format }
      assert bHtml(source) is '<img alt="sample" src="/images/sample.png" />'
      assert bHtml(source, format: 'demo') is '''
        <img
          alt="sample"
          src="/images/sample.png"
          />
      '''

  context '(errors)', ->
    it 'works', ->
      f = ->
        bHtml '''
          </img
              </img
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 5
        assert lineNumber is 2
        assert message is 'too deep indentation'
        true

      f = ->
        bHtml '''
          </img
            </img
        '''
      assert.throws f, ({ columnNumber, lineNumber, message }) ->
        assert columnNumber is 3
        assert lineNumber is 2
        assert message is 'empty element must not have a child'
        true
