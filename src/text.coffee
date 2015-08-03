{Node} = require './node'

class Text extends Node
  constructor: ({ level, @content }) ->
    super { level, type: 'text' }

  @parse: (level, node) ->
    m = node.match /^>?(.*)$/
    if m?
      new Text { level, content: m[1] }

  write: ->
    indent = [0...@level].map((i) -> ' ').join ''
    children = @children.map((i) -> i.write()).join ''
    """
    #{indent}#{@content}\n#{children}
    """

module.exports.Text = Text
