{Node} = require './node'

class Comment extends Node
  constructor: ({ level, @content }) ->
    super { level }

  @parse: (level, node) ->
    m = node.match /^<!.+$/
    if m?
      new Comment { level, content: m[0] }

  append: (prev) ->
    throw new Error('too deep indentation') if @level > prev.level + 2
    if @level > prev.level
      prev.appendChild @
    else if @level is prev.level
      prev.appendSibling @
    else if @level < prev.level
      p = prev
      p = p.parent until p.level is @level
      p.appendSibling @
    @

  write: ->
    indent = [0...@level].map((i) -> ' ').join ''
    children = @children.map((i) -> i.write()).join ''
    """
    #{indent}#{@content}\n#{children}
    """

module.exports.Comment = Comment
