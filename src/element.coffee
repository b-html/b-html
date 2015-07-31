{Node} = require './node'

class Element extends Node
  constructor: (options) ->
    super options
    @type = 'element'
    @name = options.name

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    if node.match(/^<\S+$/)
      new Element level: level, name: node.substring 1

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
    children = @children.map((i) -> i.write()).join('')
    '<' + @name + attributes + '>' + children + '</' + @name + '>'

module.exports.Element = Element
