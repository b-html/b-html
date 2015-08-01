{Node} = require './node'

class Element extends Node
  constructor: ({ level, @name }) ->
    super { level }

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    m = node.match /^<(\S+)$/
    if m?
      new Element { level, name: m[1] }

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
    children = @children.map((i) -> i.write()).join ''
    '<' + @name + attributes + '>' + children + '</' + @name + '>'

module.exports.Element = Element
