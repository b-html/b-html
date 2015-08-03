{Node} = require './node'

class Element extends Node
  constructor: ({ level, @name }) ->
    super { level, type: 'element' }

  @parse: (level, node) ->
    m = node.match /^<(\S+)$/
    if m?
      new Element { level, name: m[1] }

  # override
  appendChild: (n) ->
    @children.push n
    n.parent = @

  write: ->
    indent = [0...@level].map((i) -> ' ').join ''
    attributes = @attributes.map((i) -> i.write()).join ''
    attributes = if attributes.length > 0
      '\n' + attributes + indent + '  ' # attrs is child (+2 level)
    else
      ''
    children = @children.map((i) -> i.write()).join ''
    """
    #{indent}<#{@name}#{attributes}>
    #{children}#{indent}</#{@name}>\n
    """

module.exports.Element = Element
