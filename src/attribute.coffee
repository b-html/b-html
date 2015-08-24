{Node} = require './node'

class Attribute extends Node
  constructor: ({ level, @name, @value }) ->
    super { level, type: 'attribute' }

  @parse: (level, node) ->
    m = node.match /^@/
    return null unless m?
    m = node.match /^@(\S+)(?: (.*))?$/
    if m?
      new Attribute { level, name: m[1], value: m[2] }
    else
      throw new Error 'invalid attribute'

  append: (prev) ->
    throw new Error('too deep indentation') if @level > prev.level + 2
    throw new Error('attribute must have a parent') if @level < prev.level + 2
    prev.setAttribute @
    prev

  write: ({ format }) ->
    if format is 'demo'
      indent = [0...@level].map((i) -> ' ').join ''
      if @value?
        "#{indent}#{@name}=\"#{@value}\"\n"
      else
        "#{indent}#{@name}\n"
    else
      if @value?
        "#{@name}=\"#{@value}\""
      else
        "#{@name}"

module.exports.Attribute = Attribute
