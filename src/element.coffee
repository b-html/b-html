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

module.exports.Element = Element
