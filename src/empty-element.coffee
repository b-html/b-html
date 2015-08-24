{Node} = require './node'

class EmptyElement extends Node
  constructor: ({ level, @name }) ->
    super { level, type: 'empty element' }

  @parse: (level, node) ->
    m = node.match /^<\/(\S+)$/
    if m?
      new EmptyElement { level, name: m[1] }

  write: ({ format }) ->
    indent = [0...@level].map((i) -> ' ').join ''
    if format is 'demo'
      attributes = @attributes.map((i) -> i.write { format }).join ''
      attributes = if attributes.length > 0
        '\n' + attributes + indent + '  ' # attrs is child (+2 level)
      else
        ' '
      """
      #{indent}<#{@name}#{attributes}/>\n
      """
    else
      attributes = @attributes.map((i) -> i.write { format }).join ' '
      attributes = if attributes.length > 0
        ' ' + attributes
      else
        ''
      "<#{@name}#{attributes} />"

module.exports.EmptyElement = EmptyElement
