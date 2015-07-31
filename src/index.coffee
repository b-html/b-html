{Attribute} = require './attribute'
{Element} = require './element'
{EmptyElement} = require './empty-element'
{Text} = require './text'

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
