{Node} = require './node'

class Element extends Node
  constructor: ({ level, @name }) ->
    super { level }
    @type = 'element'

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
    aIndent = indent + '  ' # attrs is child
    attributes = ("#{aIndent}#{k}=\"#{v}\"\n" for k, v of @attributes).join ''
    attributes = if attributes.length > 0
      '\n' + attributes + aIndent
    else
      ''
    children = @children.map((i) -> i.write()).join ''
    """
    #{indent}<#{@name}#{attributes}>
    #{children}#{indent}</#{@name}>\n
    """

module.exports.Element = Element
