{Node} = require './node'

class Attribute extends Node
  constructor: ({ level, @name, @value }) ->
    super { level }

  @parse: (level, node) ->
    m = node.match /^@(\S+)\s+(.+)$/
    if m?
      new Attribute { level, name: m[1], value: m[2] }

  append: (prev) ->
    throw new Error('too deep indentation') if @level > prev.level + 2
    throw new Error('attribute requires an element') if @level < prev.level + 2
    prev.setAttribute @name, @value
    prev

  # override
  appendChild: ->
    throw new Error 'comment doesn\'t have a child'

  write: ->
    throw new Error()

module.exports.Attribute = Attribute
