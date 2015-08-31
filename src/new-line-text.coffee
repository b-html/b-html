{BaseText} = require './base-text'

class NewLineText extends BaseText
  constructor: ({ level, value }) ->
    super { level, type: 'new line text', value, isNewLine: true }

  @parse: (level, node) ->
    m = node.match /^\|(.*)$/
    if m?
      new NewLineText { level, value: m[1] }

module.exports.NewLineText = NewLineText
