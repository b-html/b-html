{Node} = require './node'

class Comment extends Node
  constructor: ({ level, @value }) ->
    super { level, type: 'comment' }

  @parse: (level, node) ->
    m = node.match /^<!--(.*)$/
    if m?
      new Comment { level, value: m[1] }

module.exports.Comment = Comment
