{Node} = require './node'

class EmptyElement extends Node
  constructor: ({ level, @name }) ->
    super { level }
    @type = 'empty element'

  @parse: (level, node) ->
    m = node.match /^<\/(\S+)$/
    if m?
      new EmptyElement { level, name: m[1] }

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
