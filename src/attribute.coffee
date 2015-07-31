{Node} = require './node'

class Attribute extends Node
  constructor: ({ level, @name, @value }) ->
    super { level }

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    m = node.match /^@(\S+)\s+(.+)$/
    if m?
      new Attribute { level, name: m[1], value: m[2] }

  append: (prev) ->
    throw new Error() unless @level > prev.level
    prev.setAttribute @name, @value
    prev

  write: ->
    throw new Error()

module.exports.Attribute = Attribute
