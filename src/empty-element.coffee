{Node} = require './node'

class EmptyElement extends Node
  constructor: ({ level, @name }) ->
    super { level, type: 'empty element' }

  @parse: (level, node) ->
    m = node.match /^<\/(\S+)$/
    if m?
      new EmptyElement { level, name: m[1] }

  write: ->
    indent = [0...@level].map((i) -> ' ').join ''
    attributes = @attributes.map((i) -> i.write()).join ''
    attributes = if attributes.length > 0
      '\n' + attributes + indent + '  ' # attrs is child (+2 level)
    else
      ' '
    """
    #{indent}<#{@name}#{attributes}/>\n
    """

module.exports.EmptyElement = EmptyElement
