{Attribute} = require './attribute'
{BHtmlComment} = require './b-html-comment'
{Element} = require './element'
{EmptyElement} = require './empty-element'
{HtmlComment} = require './html-comment'
{NewLineText} = require './new-line-text'
{Text} = require './text'
{DefaultText} = require './default-text'

parseLevel = (s) ->
  match = s.match /^(?:  )*/
  level = match[0].length
  node = s.substring level
  { level, node }

parseNode = (level, node) ->
  [
    BHtmlComment
    HtmlComment
    EmptyElement
    Element
    Attribute
    Text
    NewLineText
    DefaultText
  ].reduce (parsed, i) ->
    return parsed if parsed?
    i.parse level, node
  , null

module.exports = (s, { demo } = { demo: false }) ->
  root = parseNode 0, '<root'
  root.parent = root
  prev = root
  s.split(/\n/).forEach (line) ->
    return if line.length is 0
    { level, node } = parseLevel line
    n = parseNode level, node
    prev = n.append prev
  html = root.children.map((i) -> i.write { demo }).join('')
  if demo
    html.substring(0, html.length - 1)
  else
    html
