{Node} = require './node'

class EmptyElement extends Node
  constructor: ({ level, @name }) ->
    super { level }

  @parse: (level, node) ->
    m = node.match /^<\/(\S+)$/
    if m?
      new EmptyElement { level, name: m[1] }

  append: (prev) ->
    throw new Error('too deep indentation') if @level > prev.level + 2
    if @level > prev.level
      prev.appendChild @
    else if @level is prev.level
      prev.appendSibling @
    else if @level < prev.level
      p = prev
      p = p.parent until p.level is @level
      p.appendSibling @
    @

  # override
  appendChild: ->
    throw new Error 'empty element doesn\'t have a child'

  write: ->
    indent = [0...@level].map((i) -> ' ').join ''
    aIndent = indent + '  ' # attrs is child
    attributes = ("#{aIndent}#{k}=\"#{v}\"\n" for k, v of @attributes).join ''
    attributes = if attributes.length > 0
      '\n' + attributes + aIndent
    else
      ' '
    """
    #{indent}<#{@name}#{attributes}/>\n
    """

module.exports.EmptyElement = EmptyElement
