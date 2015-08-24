{Node} = require './node'

class Element extends Node
  constructor: ({ level, @name }) ->
    super { level, type: 'element' }

  @parse: (level, node) ->
    m = node.match /^</
    return null unless m?
    m = node.match /^<(\S+)$/
    if m?
      new Element { level, name: m[1] }
    else
      throw new Error 'invalid element'

  # override
  appendChild: (n) ->
    @children.push n
    n.parent = @

  write: ({ format }) ->
    indent = [0...@level].map((i) -> ' ').join ''
    if format is 'demo'
      attributes = @attributes.map((i) -> i.write { format }).join ''
      attributes = if attributes.length > 0
        '\n' + attributes + indent + '  ' # attrs is child (+2 level)
      else
        ''
      children = @children.map((i) -> i.write { format }).join ''
      """
      #{indent}<#{@name}#{attributes}>
      #{children}#{indent}</#{@name}>\n
      """
    else
      attributes = @attributes.map((i) -> i.write { format }).join ' '
      attributes = if attributes.length > 0
        ' ' + attributes
      else
        ''
      children = @children.map((i) -> i.write { format }).join ''
      """
      <#{@name}#{attributes}>#{children}</#{@name}>
      """

module.exports.Element = Element
