{Node} = require './node'

class BaseText extends Node
  constructor: ({ level, type, @content, @isNewLine }) ->
    super { level, type }

module.exports.BaseText = BaseText
