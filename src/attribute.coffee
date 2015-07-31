{Node} = require './node'

class Attribute extends Node
  constructor: (options) ->
    super options
    @type = 'attribute'
    @name = options.name
    @value = options.value

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    m = node.match(/^@(\S+)\s+(.+)$/)
    if m
      new Attribute level: level, name: m[1], value: m[2]

  append: (prev) ->
    if @level > prev.level
      prev.setAttribute @name, @value
      prev
    else
      throw new Error()

  write: ->
    throw new Error()

module.exports.Attribute = Attribute
