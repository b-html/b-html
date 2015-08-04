{Node} = require './node'

class Text extends Node
  constructor: ({ level, @content }) ->
    super { level, type: 'text' }

  @parse: (level, node) ->
    m = node.match /^>?(.*)$/
    if m?
      new Text { level, content: m[1] }

  write: ({ demo }) ->
    indent = [0...@level].map((i) -> ' ').join ''
    children = @children.map((i) -> i.write { demo }).join ''
    if demo
      """
      #{indent}#{@content}\n#{children}
      """
    else
      "#{@content}#{children}"

module.exports.Text = Text
