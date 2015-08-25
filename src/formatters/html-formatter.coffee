class HtmlFormatter
  constructor: ->
    @format = @format.bind @

  format: (node) ->
    switch node.type
      when 'attribute'
        name = node.name
        value = node.value
        if value?
          "#{name}=\"#{value}\""
        else
          "#{name}"
      when 'comment'
        value = node.value
        "<!--#{value}-->"
      when 'doctype'
        value = node.value
        "<!DOCTYPE #{value}>"
      when 'element'
        name = node.name
        attributes = node.attributes.map((i) => i.write { @format }).join ' '
        attributes = if attributes.length > 0
          ' ' + attributes
        else
          ''
        children = node.children.map((i) => i.write { @format }).join ''
        """
        <#{name}#{attributes}>#{children}</#{name}>
        """
      when 'empty element'
        attributes = node.attributes.map((i) => i.write { @format }).join ' '
        attributes = if attributes.length > 0
          ' ' + attributes
        else
          ''
        "<#{node.name}#{attributes} />"
      when 'root element'
        node.children.map((i) => i.write { @format }).join ''
      else # default-text or new-line-text or text
        isNewLine = node.isNewLine
        content = node.content
        children = node.children.map((i) => i.write { @format }).join ''
        if isNewLine
          "\n#{content}#{children}"
        else
          "#{content}#{children}"

module.exports.HtmlFormatter = HtmlFormatter