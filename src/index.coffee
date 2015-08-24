{Attribute} = require './attribute'
{Comment} = require './comment'
{DefaultText} = require './default-text'
{Doctype} = require './doctype'
{Element} = require './element'
{EmptyElement} = require './empty-element'
{NewLineText} = require './new-line-text'
{Text} = require './text'

parseLevel = (s) ->
  match = s.match /^(?:  )*/
  level = match[0].length
  node = s.substring level
  { level, node }

parseNode = (level, node) ->
  [
    Doctype      # <!doctype
    Comment      # <!--
    EmptyElement # </
    Element      # <
    Attribute    # @
    Text         # >
    NewLineText  # |
    DefaultText  # others
  ].reduce (parsed, i) ->
    return parsed if parsed?
    i.parse level, node
  , null

module.exports = (s, { demo, format } = {}) ->
  format ?= (if (demo ? false) then 'demo' else 'html')
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
      error.columnNumber = level + 1
      error.message = e.message
      throw error
  html = root.children.map((i) -> i.write { format }).join('')
  if format is 'demo'
    html.substring(0, html.length - 1)
  else
    html
