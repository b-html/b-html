{Node} = require './node'

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

module.exports.Text = Text
