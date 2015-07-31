{Node} = require './node'
{Attribute} = require './attribute'
{Element} = require './element'
{EmptyElement} = require './empty-element'

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

parse = (s) ->
  [
    EmptyElement
    Element
    Attribute
    Text
    parse: (s) ->
      { level, node } = Node.parseBasic s
      new Text level: level, name: node
  ].reduce (parsed, i) ->
    return parsed if parsed?
    i.parse s
  , null

module.exports = (s) ->
  root = parse '<root'
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    return if line.trim().length is 0
    n = parse line
    prev = n.append prev
  root.children.map((i) -> i.write()).join('')
