class HtmlFormatter
  format: (nodes, options) ->
    nodes.map((i) => @_format i, options).join ''

  _format: (node, options) ->
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
        attributes = node.attributes.map((i) => @_format i, options).join ' '
        attributes = if attributes.length > 0
          ' ' + attributes
        else
          ''
        children = node.children.map((i) => @_format i, options).join ''
        """
        <#{name}#{attributes}>#{children}</#{name}>
        """
      when 'empty element'
        attributes = node.attributes.map((i) => @_format i, options).join ' '
        attributes = if attributes.length > 0
          ' ' + attributes
        else
          ''
        "<#{node.name}#{attributes} />"
      else # default-text or new-line-text or text
        isNewLine = node.isNewLine
        content = node.content
        children = node.children.map((i) => @_format i, options).join ''
        if isNewLine
          "\n#{content}#{children}"
        else
          "#{content}#{children}"

module.exports.HtmlFormatter = HtmlFormatter
