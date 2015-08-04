{BaseText} = require './base-text'

class DefaultText extends BaseText
  constructor: ({ level, content }) ->
    super { level, type: 'default text', content, isNewLine: false }

  @parse: (level, node) ->
    m = node.match /^(.*)$/
    if m?
      new DefaultText { level, content: m[1] }

module.exports.DefaultText = DefaultText
