{Node} = require './node'

class EmptyElement extends Node
  constructor: ({ level, @name }) ->
    super { level }

  @parse: (s, prevLevel) ->
    { level, node } = Node.parseBasic s, prevLevel
    m = node.match /^<\/(\S+)$/
    if m?
      new EmptyElement { level, name: m[1] }

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
    attributes = (" #{k}=\"#{v}\"" for k, v of @attributes).join ''
    '<' + @name + attributes + ' />'

module.exports.EmptyElement = EmptyElement
