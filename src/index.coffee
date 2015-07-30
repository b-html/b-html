parseEmptyElement = (s) ->
  if s.match(/^<\/\S+$/)
    name: s.substring 2
    type: 'empty element'
    value: null
    write: ->
      attributes = (" #{k}=\"#{v}\"" for k, v of @attributes).join ''
      '<' + @name + attributes + ' />'

parseElement = (s) ->
  if s.match(/^<\S+$/)
    name: s.substring 1
    type: 'element'
    value: null
    write: ->
      attributes = (" #{k}=\"#{v}\"" for k, v of @attributes).join ''
      children = @children.map((i) -> i.write()).join('')
      '<' + @name + attributes + '>' + children + '</' + @name + '>'

parseAttribute = (s) ->
  m = s.match(/^@(\S+)\s+(.+)$/)
  if m
    name: m[1]
    type: 'attribute'
    value: m[2]
    write: ->
      throw new Error()

parseText = (s) ->
  if s.match(/^>.+$/)
    name: s.substring(1)
    type: 'text'
    value: null
    write: ->
      @name

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
        name: s
        type: 'text'
        value: null
        write: -> s
    ].some (f) ->
      parsed = f node
    new Node {
      level, parsed,
      name: parsed.name, type: parsed.type, value: parsed.value
    }

  setAttribute: (name, value) ->
    @attributes[name] = value

  appendChild: (n) ->
    @children.push n
    n.parent = @

  appendTo: (prev) ->
    if @level > prev.level
      if @type is 'attribute'
        prev.setAttribute @name, @value
        return prev
      else if @type is 'element' or @type is 'empty element'
        prev.appendChild @
        return @
      else if @type is 'text'
        prev.appendChild @
        return @
      else
        throw new Error 'unknown type'
    else if @level is prev.level
      if @type is 'attribute'
        throw new Error()
      else if @type is 'element' or @type is 'empty element'
        prev.parent.appendChild @
        return @
      else if @type is 'text'
        prev.parent.appendChild @
        return @
      else
        throw new Error 'unknown type'
    else if @level < prev.level
      if @type is 'attribute'
        throw new Error()
      else if @type is 'element' or @type is 'empty element'
        p = prev
        p = p.parent until p.level is @level
        p.parent.appendChild @
        return @
      else if @type is 'text'
        p = prev
        p = p.parent until p.level is @level
        p.parent.appendChild @
        return @
      else
        throw new Error 'unknown type'
    @

  write: ->
    @parsed.write.apply @, []

module.exports = (s) ->
  root = Node.parse '<root'
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    return if line.trim().length is 0
    n = Node.parse line
    prev = n.appendTo prev
  root.children.map((i) -> i.write()).join('')
