{Node} = require './node'

class BaseText extends Node
  constructor: ({ level, type, @value, @isNewLine }) ->
    super { level, type }

module.exports.BaseText = BaseText
