{Node} = require './node'

class BaseText extends Node
  constructor: ({ level, type, @content, @isNewLine }) ->
    super { level, type }

  write: ({ format }) ->
    indent = [0...@level].map((i) -> ' ').join ''
    children = @children.map((i) -> i.write { format }).join ''
    if format is 'demo'
      """
      #{indent}#{@content}\n#{children}
      """
    else
      if @isNewLine
        "\n#{@content}#{children}"
      else
        "#{@content}#{children}"

module.exports.BaseText = BaseText
