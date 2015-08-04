{BaseText} = require './base-text'

class NewLineText extends BaseText
  constructor: ({ level, content }) ->
    super { level, type: 'new line text', content, isNewLine: true }

  @parse: (level, node) ->
    m = node.match /^\|(.*)$/
    if m?
      new NewLineText { level, content: m[1] }

module.exports.NewLineText = NewLineText
