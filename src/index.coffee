{Attribute} = require './attribute'
{BHtmlComment} = require './b-html-comment'
{DefaultText} = require './default-text'
{Doctype} = require './doctype'
{Element} = require './element'
{EmptyElement} = require './empty-element'
{HtmlComment} = require './html-comment'
{NewLineText} = require './new-line-text'
{Text} = require './text'

parseLevel = (s) ->
  match = s.match /^(?:  )*/
  level = match[0].length
  node = s.substring level
  { level, node }

parseNode = (level, node) ->
  [
    BHtmlComment
    Doctype
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
  s.split(/\n/).forEach (line, index) ->
    return if line.length is 0
    try
      { level, node } = parseLevel line
      n = parseNode level, node
      prev = n.append prev
    catch e
      error = new Error()
      error.lineNumber = index + 1
      error.columnNumber = level
      error.message = e.message
      throw error
  html = root.children.map((i) -> i.write { demo }).join('')
  if demo
    html.substring(0, html.length - 1)
  else
    html
