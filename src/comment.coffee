{Node} = require './node'

class Comment extends Node
  constructor: ({ level, @content }) ->
    super { level }
    @type = 'comment'

  @parse: (level, node) ->
    m = node.match /^<!.+$/
    if m?
      new Comment { level, content: m[0] }

  write: ->
    ''

module.exports.Comment = Comment
