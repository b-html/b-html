{Node} = require './node'

class BaseText extends Node
  constructor: ({ level, type, @content, @isNewLine }) ->
    super { level, type }

  write: ({ demo }) ->
    indent = [0...@level].map((i) -> ' ').join ''
    children = @children.map((i) -> i.write { demo }).join ''
    if demo
      """
      #{indent}#{@content}\n#{children}
      """
    else
      if @isNewLine
        "\n#{@content}#{children}"
      else
        "#{@content}#{children}"

module.exports.BaseText = BaseText
