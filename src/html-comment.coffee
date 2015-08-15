{Node} = require './node'

class HtmlComment extends Node
  constructor: ({ level, @value }) ->
    super { level, type: 'html comment' }

  @parse: (level, node) ->
    m = node.match /^<!--(.*)$/
    if m?
      new HtmlComment { level, value: m[1] }

  write: ({ demo }) ->
    if demo
      indent = [0...@level].map((i) -> ' ').join ''
      "#{indent}<!--#{@value}-->\n"
    else
      "<!--#{@value}-->"

module.exports.HtmlComment = HtmlComment
