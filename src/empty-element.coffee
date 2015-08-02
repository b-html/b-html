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
    attributes = (
      for k, v of @attributes
        if v?
          "#{aIndent}#{k}=\"#{v}\"\n"
        else
          "#{aIndent}#{k}\n"
    ).join ''
    attributes = if attributes.length > 0
      '\n' + attributes + aIndent
    else
      ' '
    """
    #{indent}<#{@name}#{attributes}/>\n
    """

module.exports.EmptyElement = EmptyElement
