class Node
  constructor: ({ @level }) ->
    @parent = null
    @attributes = {}
    @children = []

  @parseBasic: (s, prevLevel) ->
    match = s.match /^(?:  )*/
    level = match[0].length
    node = s.substring level
    { level, node }

  appendChild: (n) ->
    @children.push n
    n.parent = @

  appendSibling: (n) ->
    @parent.appendChild n

  setAttribute: (name, value) ->
    @attributes[name] = value

module.exports.Node = Node
