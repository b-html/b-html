{BaseText} = require './base-text'

class Text extends BaseText
  constructor: ({ level, value }) ->
    super { level, type: 'text', value, isNewLine: false }

  @parse: (level, node) ->
    m = node.match /^>(.*)$/
    if m?
      new Text { level, value: m[1] }

module.exports.Text = Text
