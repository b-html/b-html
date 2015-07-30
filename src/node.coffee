class Node
  constructor: ({ @level }) ->
    @parent = null
    @attributes = {}
    @children = []

  @parseBasic: (s) ->
    match = s.match /^(\s*)(.+)$/
    throw new Error() unless match?
    [_, space, node] = match
    level = space.length
    { level, node }

  appendChild: (n) ->
    @children.push n
    n.parent = @

  setAttribute: (name, value) ->
    @attributes[name] = value

module.exports.Node = Node
