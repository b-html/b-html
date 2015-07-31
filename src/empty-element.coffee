{Node} = require './node'

class EmptyElement extends Node
  constructor: (options) ->
    super options
    @type = 'empty element'
    @name = options.name

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    if node.match(/^<\/\S+$/)
      new EmptyElement level: level, name: node.substring 2

  append: (prev) ->
    if @level > prev.level
      prev.appendChild @
    else if @level is prev.level
      prev.parent.appendChild @
    else if @level < prev.level
      p = prev
      p = p.parent until p.level is @level
      p.parent.appendChild @
    @

  write: ->
    attributes = (" #{k}=\"#{v}\"" for k, v of @attributes).join ''
    '<' + @name + attributes + ' />'

module.exports.EmptyElement = EmptyElement
