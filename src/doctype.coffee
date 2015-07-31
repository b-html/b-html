{Node} = require './node'

class Doctype extends Node
  constructor: ({ level, @content }) ->
    super { level }

  @parse: (s) ->
    { level, node } = Node.parseBasic s
    m = node.match /^<!DOCTYPE.+$/
    if m?
      new Doctype { level, content: m[0] }

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
    @content

module.exports.Doctype = Doctype
