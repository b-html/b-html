class Node
  constructor: ({ @level }) ->
    @parent = null
    @attributes = {}
    @children = []

  @parse: (s) ->
    [
      EmptyElement
      Element
      Attribute
      Text
      parse: (s) =>
        { level, node } = Node.parseBasic s
        new Text level: level, name: node
    ].reduce (parsed, i) ->
      return parsed if parsed?
      i.parse s

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

class Text extends Node
  constructor: (options) ->
    super options
    @type = 'text'
    @name = options.name

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    if node.match(/^>.+$/)
      new Text level: level, name: node.substring(1)

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
    @name

module.exports = (s) ->
  root = Node.parse '<root'
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    return if line.trim().length is 0
    n = Node.parse line
    prev = n.append prev
  root.children.map((i) -> i.write()).join('')
