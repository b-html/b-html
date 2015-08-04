{Node} = require './node'

class DefaultText extends Node
  constructor: ({ level, @content }) ->
    super { level, type: 'default text' }

  @parse: (level, node) ->
    m = node.match /^(.*)$/
    if m?
      new DefaultText { level, content: m[1] }

  write: ({ demo }) ->
    indent = [0...@level].map((i) -> ' ').join ''
    children = @children.map((i) -> i.write { demo }).join ''
    if demo
      """
      #{indent}#{@content}\n#{children}
      """
    else
      "#{@content}#{children}"

module.exports.DefaultText = DefaultText
