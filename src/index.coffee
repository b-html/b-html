parseEmptyElement = (s) ->
  if s.match(/^<\/\S+$/)
    name = s.substring(2)
    [name, 'empty element', null, ->
      attributes = (" #{k}=\"#{v}\"" for k, v of @attributes).join ''
      '<' + name + attributes + ' />'
    ]

parseElement = (s) ->
  if s.match(/^<\S+$/)
    name = s.substring(1)
    [name, 'element', null, ->
      attributes = (" #{k}=\"#{v}\"" for k, v of @attributes).join ''
      children = @children.map((i) -> i.write()).join('')
      '<' + name + attributes + '>' + children + '</' + name + '>'
    ]

parseAttribute = (s) ->
  m = s.match(/^@(\S+)\s+(.+)$/)
  if m
    [m[1], 'attribute', m[2], null]

parseText = (s) ->
  if s.match(/^>.+$/)
    name = s.substring(1)
    [name, 'text', null, -> name]

class Node
  constructor: ({ @level, @parsed, @name, @type, @value }) ->
    @parent = null
    @attributes = {}
    @children = []

  @parse: (s) ->
    match = s.match /^(\s*)(.+)$/
    throw new Error() unless match?
    [_, space, node] = match
    level = space.length
    parsed = null
    [
      parseEmptyElement
      parseElement
      parseAttribute
      parseText
      (s) ->
        [s, 'text', null, -> s]
    ].some (f) ->
      parsed = f node
    new Node {
      level, parsed,
      name: parsed[0], type: parsed[1], value: parsed[2]
    }

  setAttribute: (name, value) ->
    @attributes[name] = value

  appendChild: (n) ->
    @children.push n
    n.parent = @

  write: ->
    @parsed[3].apply @, []

parse = (s) ->
  root = Node.parse '<root'
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    return if line.trim().length is 0
    n = Node.parse line
    if n.level > prev.level
      if n.type is 'attribute'
        prev.setAttribute n.name, n.value
        n = prev # for `prev = n`
      else if n.type is 'element' or n.type is 'empty element'
        prev.appendChild n
      else if n.type is 'text'
        prev.appendChild n
      else
        throw new Error 'unknown type'
    else if n.level is prev.level
      if n.type is 'attribute'
        throw new Error()
      else if n.type is 'element' or n.type is 'empty element'
        prev.parent.appendChild n
      else if n.type is 'text'
        prev.parent.appendChild n
      else
        throw new Error 'unknown type'
    else if n.level < prev.level
      if n.type is 'attribute'
        throw new Error()
      else if n.type is 'element' or n.type is 'empty element'
        p = prev
        p = p.parent until p.level is n.level
        p.parent.appendChild n
      else if n.type is 'text'
        p = prev
        p = p.parent until p.level is n.level
        p.parent.appendChild n
      else
        throw new Error 'unknown type'
    prev = n
  root

module.exports = (s) ->
  root = parse s
  root.children.map((i) -> i.write()).join('')
