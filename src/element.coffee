{Node} = require './node'

class Element extends Node
  constructor: ({ level, @name }) ->
    super { level }

  @parse: (level, node) ->
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
    indent = [0...@level].map((i) -> ' ').join ''
    attributes = ("#{indent}#{k}=\"#{v}\"" for k, v of @attributes).join ''
    attributes += if attributes.length > 0 then '\n' else ''
    children = @children.map((i) -> i.write()).join ''
    """
    #{indent}<#{@name}#{attributes}>
    #{indent}#{children}</#{@name}>\n
    """

module.exports.Element = Element
