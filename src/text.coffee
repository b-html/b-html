{BaseText} = require './base-text'

class Text extends BaseText
  constructor: ({ level, content }) ->
    super { level, type: 'text', content, isNewLine: false }

  @parse: (level, node) ->
    m = node.match /^>(.*)$/
    if m?
      new Text { level, content: m[1] }

module.exports.Text = Text
