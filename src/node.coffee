class Node
  constructor: ({ @level, @type }) ->
    @parent = null
    @attributes = []
    @children = []

  append: (prev) ->
    throw new Error('too deep indentation') if @level > prev.level + 2
    if @level > prev.level
      prev.appendChild @
    else if @level is prev.level
      prev.appendSibling @
    else if @level < prev.level
      p = prev
      p = p.parent until p.level is @level
      p.appendSibling @
    @

  appendChild: ->
    throw new Error "#{@type} must not have a child"

  appendSibling: (n) ->
    @parent.appendChild n

  setAttribute: (attr) ->
    @attributes.push attr

module.exports.Node = Node
