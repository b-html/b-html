class Node
  constructor: ({ @level, @name, @type, @value }) ->
    @parent = null
    @attributes = {}
    @children = []

  @parse: (s) ->
    match = s.match /^(\s*)(\S+)(?:\s+(.+))?$/
    throw new Error() unless match?
    [_, space, name, value] = match
    type = if name.match(/^</)
      'element'
    else if name.match(/^@/)
      'attribute'
    else
      'text'
    new Node
      level: space.length
      name: if type isnt 'text' then name.substring(1) else name
      type: type
      value: value

  setAttribute: (name, value) ->
    @attributes[name] = value

  appendChild: (n) ->
    @children.push n
    n.parent = @

parse = (s) ->
  root = Node.parse '<root'
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    n = Node.parse line
    if n.level > prev.level
      if n.type is 'attribute'
        prev.setAttribute n.name, n.value
        n = prev # for `prev = n`
      else if n.type is 'element'
        prev.appendChild n
      else if n.type is 'text'
        prev.appendChild n
      else
        throw new Error 'unknown type'
    else if n.level is prev.level
      if n.type is 'attribute'
        throw new Error()
      else if n.type is 'element'
        prev.parent.appendChild n
      else if n.type is 'text'
        prev.parent.appendChild n
      else
        throw new Error 'unknown type'
    else if n.level < prev.level
      if n.type is 'attribute'
        throw new Error()
      else if n.type is 'element'
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

write = (n) ->
  if n.type is 'element'
    attributes = (" #{k}=\"#{v}\"" for k, v of n.attributes).join ''
    children = n.children.map(write).join('')
    '<' + n.name + attributes + '>' + children + '</' + n.name + '>'
  else if n.type is 'text'
    n.name

module.exports = (s) ->
  root = parse s
  root.children.map(write).join('')
