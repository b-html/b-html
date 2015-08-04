{Node} = require './node'

class NewLineText extends Node
  constructor: ({ level, @content }) ->
    super { level, type: 'new line text' }

  @parse: (level, node) ->
    m = node.match /^\|(.*)$/
    if m?
      new NewLineText { level, content: m[1] }

  write: ({ demo }) ->
    indent = [0...@level].map((i) -> ' ').join ''
    children = @children.map((i) -> i.write { demo }).join ''
    if demo
      """
      #{indent}#{@content}\n#{children}
      """
    else
      "\n#{@content}#{children}"

module.exports.NewLineText = NewLineText
