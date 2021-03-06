class DemoFormatter
  format: (nodes, options) ->
    html = nodes.map((i) => @_format i, options).join ''
    html.substring(0, html.length - 1)

  _format: (node, options) ->
    indent = [0...node.level].map((i) -> ' ').join ''
    switch node.type
      when 'attribute'
        name = node.name
        value = node.value
        if value?
          "#{indent}#{name}=\"#{value}\"\n"
        else
          "#{indent}#{name}\n"
      when 'comment'
        value = node.value
        "#{indent}<!--#{value}-->\n"
      when 'doctype'
        value = node.value
        "#{indent}<!DOCTYPE #{value}>\n"
      when 'element'
        name = node.name
        attributes = node.attributes.map((i) => @_format i, options).join ''
        attributes = if attributes.length > 0
          '\n' + attributes + indent + '  ' # attrs is child (+2 level)
        else
          ''
        children = node.children.map((i) => @_format i, options).join ''
        """
        #{indent}<#{name}#{attributes}>
        #{children}#{indent}</#{name}>\n
        """
      when 'empty element'
        name = node.name
        attributes = node.attributes.map((i) => @_format i, options).join ''
        attributes = if attributes.length > 0
          '\n' + attributes + indent + '  ' # attrs is child (+2 level)
        else
          ' '
        """
        #{indent}<#{name}#{attributes}/>\n
        """
      else # default-text or new-line-text or text
        isNewLine = node.isNewLine
        value = node.value
        children = node.children.map((i) => @_format i, options).join ''
        """
        #{indent}#{value}\n#{children}
        """

module.exports.DemoFormatter = DemoFormatter
