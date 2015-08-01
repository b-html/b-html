{Attribute} = require './attribute'
{Comment} = require './comment'
{Element} = require './element'
{EmptyElement} = require './empty-element'
{Text} = require './text'

parse = (s, prevLevel) ->
  [
    Comment
    EmptyElement
    Element
    Attribute
    Text
  ].reduce (parsed, i) ->
    return parsed if parsed?
    i.parse s, prevLevel
  , null

module.exports = (s) ->
  root = parse '<root', 0
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    n = parse line, prev.level
    prev = n.append prev
  root.children.map((i) -> i.write()).join('')
