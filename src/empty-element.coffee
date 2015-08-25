{Node} = require './node'

class EmptyElement extends Node
  constructor: ({ level, @name }) ->
    super { level, type: 'empty element' }

  @parse: (level, node) ->
    m = node.match /^<\/(\S+)$/
    if m?
      new EmptyElement { level, name: m[1] }

module.exports.EmptyElement = EmptyElement
