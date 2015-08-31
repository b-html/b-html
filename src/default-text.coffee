{BaseText} = require './base-text'

class DefaultText extends BaseText
  constructor: ({ level, value }) ->
    super { level, type: 'text', value, isNewLine: false }

  @parse: (level, node) ->
    m = node.match /^(.*)$/
    if m?
      new DefaultText { level, value: m[1] }

module.exports.DefaultText = DefaultText
