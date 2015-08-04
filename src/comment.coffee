{Node} = require './node'

class Comment extends Node
  constructor: ({ level }) ->
    super { level, type: 'comment' }

  @parse: (level, node) ->
    m = node.match /^<!.*$/
    if m?
      new Comment { level }

  write: ({ demo }) ->
    if demo
      ''
    else
      ''

module.exports.Comment = Comment
