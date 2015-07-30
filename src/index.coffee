parseEmptyElement = (s) ->
  if s.match(/^<\/\S+$/)
    name: s.substring 2
    type: 'empty element'
    value: null
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

parseElement = (s) ->
  if s.match(/^<\S+$/)
    name: s.substring 1
    type: 'element'
    value: null
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

parseAttribute = (s) ->
  m = s.match(/^@(\S+)\s+(.+)$/)
  if m
    name: m[1]
    type: 'attribute'
    value: m[2]
    append: (prev) ->
      if @level > prev.level
        prev.setAttribute @name, @value
        prev
      else
        throw new Error()
    write: ->
      throw new Error()

parseText = (s) ->
  if s.match(/^>.+$/)
    name: s.substring(1)
    type: 'text'
    value: null
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
    @parsed.append.apply @, [prev]

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
