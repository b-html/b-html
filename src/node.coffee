class Node
  constructor: ({ @level }) ->
    @parent = null
    @attributes = {}
    @children = []

  appendChild: (n) ->
    @children.push n
    n.parent = @

  appendSibling: (n) ->
    @parent.appendChild n

  setAttribute: (name, value) ->
    @attributes[name] = value

module.exports.Node = Node
