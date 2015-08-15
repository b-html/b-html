{Node} = require './node'

class BHtmlComment extends Node
  constructor: ({ level }) ->
    super { level, type: 'b-html comment' }

  @parse: (level, node) ->
    m = node.match /^<-.*$/
    if m?
      new BHtmlComment { level }

  write: ({ demo }) ->
    if demo
      ''
    else
      ''

module.exports.BHtmlComment = BHtmlComment
