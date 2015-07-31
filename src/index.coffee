{Attribute} = require './attribute'
{Comment} = require './comment'
{Element} = require './element'
{EmptyElement} = require './empty-element'
{Text} = require './text'

parse = (s) ->
  [
    Comment
    EmptyElement
    Element
    Attribute
    Text
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
