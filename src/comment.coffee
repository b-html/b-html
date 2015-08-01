{Node} = require './node'

class Comment extends Node
  constructor: ({ level, @content }) ->
    super { level }

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    m = node.match /^<!.+$/
    if m?
      new Comment { level, content: m[0] }

  append: (prev) ->
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
    @content

module.exports.Comment = Comment
