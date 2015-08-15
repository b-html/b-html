{Node} = require './node'

class Doctype extends Node
  constructor: ({ level, @value }) ->
    super { level, type: 'doctype' }

  @parse: (level, node) ->
    m = node.match /^<!(?:doctype|DOCTYPE)(.*)$/
    if m?
      new Doctype { level, value: m[1] }

  write: ({ demo }) ->
    if demo
      indent = [0...@level].map((i) -> ' ').join ''
      "#{indent}<!DOCTYPE#{@value}>\n"
    else
      "<!DOCTYPE#{@value}>"

module.exports.Doctype = Doctype
