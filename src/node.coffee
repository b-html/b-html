class Node
  constructor: ({ @level }) ->
    @type = 'unknown' # override in child class
    @parent = null
    @attributes = {}
    @children = []

  appendChild: ->
    throw new Error "#{@type} doesn't have a child"

  appendSibling: (n) ->
    @parent.appendChild n

  setAttribute: (name, value) ->
    @attributes[name] = value

module.exports.Node = Node
