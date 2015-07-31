{Node} = require './node'

class Text extends Node
  constructor: ({ level, @content }) ->
    super { level }

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    m = node.match /^>?(.+)$/
    if m?
      new Text { level, content: m[1] }

  append: (prev) ->
    if @level > prev.level
      prev.appendChild @
    else if @level is prev.level
      prev.parent.appendChild @
    else if @level < prev.level
      p = prev
      p = p.parent until p.level is @level
      p.parent.appendChild @
    @

  write: ->
    @content

module.exports.Text = Text
