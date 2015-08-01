{Node} = require './node'

class Text extends Node
  constructor: ({ level, @content }) ->
    super { level }

  @parse: (s, prevLevel) ->
    { level, node } = Node.parseBasic s, prevLevel
    m = node.match /^>?(.*)$/
    if m?
      new Text { level, content: m[1] }

  append: (prev) ->
    if @level > prev.level
      prev.appendChild @
    else if @level is prev.level
      prev.appendSibling @
    else if @level < prev.level
      p = prev
      p = p.parent until p.level is @level
      p.appendSibling @
    @

  write: ->
    @content

module.exports.Text = Text
