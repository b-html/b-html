{Node} = require './node'

class Comment extends Node
  constructor: ({ level, @value }) ->
    super { level, type: 'comment' }

  @parse: (level, node) ->
    m = node.match /^<!--(.*)$/
    if m?
      new Comment { level, value: m[1] }

  write: ({ format }) ->
    if format is 'demo'
      indent = [0...@level].map((i) -> ' ').join ''
      "#{indent}<!--#{@value}-->\n"
    else
      "<!--#{@value}-->"

module.exports.Comment = Comment
