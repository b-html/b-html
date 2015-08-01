{Attribute} = require './attribute'
{Comment} = require './comment'
{Element} = require './element'
{EmptyElement} = require './empty-element'
{Text} = require './text'

parseLevel = (s) ->
  match = s.match /^(?:  )*/
  level = match[0].length
  node = s.substring level
  { level, node }

parseNode = (level, node) ->
  [
    Comment
    EmptyElement
    Element
    Attribute
    Text
  ].reduce (parsed, i) ->
    return parsed if parsed?
    i.parse level, node
  , null

module.exports = (s) ->
  root = parseNode 0, '<root'
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    return if line.length is 0
    { level, node } = parseLevel line
    n = parseNode level, node
    prev = n.append prev
  root.children.map((i) -> i.write()).join('')
