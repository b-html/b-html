class Node
  constructor: ({ @level, @name, @type, @value }) ->
    @parent = null
    @attributes = {}
    @children = []

  @parseNameAndType: (nameAndType) ->
    if nameAndType.match(/^<\//)
      [nameAndType.substring(2), 'empty element']
    else if nameAndType.match(/^</)
      [nameAndType.substring(1), 'element']
    else if nameAndType.match(/^@/)
      [nameAndType.substring(1), 'attribute']
    else if nameAndType.match(/^>/)
      [nameAndType.substring(1), 'text']
    else
      [nameAndType, 'text']

  @parse: (s) ->
    match = s.match /^(\s*)(\S+)(?:\s+(.+))?$/
    throw new Error() unless match?
    [_, space, nameAndType, value] = match
    level = space.length
    [name, type] = @parseNameAndType nameAndType
    new Node { level, name, type, value }

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

write = (n) ->
  if n.type is 'empty element'
    attributes = (" #{k}=\"#{v}\"" for k, v of n.attributes).join ''
    '<' + n.name + attributes + ' />'
  else if n.type is 'element'
    attributes = (" #{k}=\"#{v}\"" for k, v of n.attributes).join ''
    children = n.children.map(write).join('')
    '<' + n.name + attributes + '>' + children + '</' + n.name + '>'
  else if n.type is 'text'
    n.name

module.exports = (s) ->
  root = parse s
  root.children.map(write).join('')
