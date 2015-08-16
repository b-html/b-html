{Node} = require './node'

class Doctype extends Node
  @doctypes: [
    pattern: /^html(?: 5)?$/i
    root: 'html'
    pi: ''
    fpi: ''
    dtd: ''
  ,
    pattern: /^html(?: 4\.01)? strict$/i
    root: 'HTML'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD HTML 4.01//EN"'
    dtd: '"http://www.w3.org/TR/html4/strict.dtd"'
  ,
    pattern: /^html(?: 4\.01)? transitional$/i
    root: 'HTML'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD HTML 4.01 Transitional//EN"'
    dtd: '"http://www.w3.org/TR/html4/loose.dtd"'
  ,
    pattern: /^html(?: 4\.01)? frameset$/i
    root: 'HTML'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD HTML 4.01 Frameset//EN"'
    dtd: '"http://www.w3.org/TR/html4/frameset.dtd"'
  ,
    pattern: /^xhtml(?: 1\.0)? strict$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD XHTML 1.0 Strict//EN"'
    dtd: '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"'
  ,
    pattern: /^xhtml(?: 1\.0)? transitional$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD XHTML 1.0 Transitional//EN"'
    dtd: '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"'
  ,
    pattern: /^xhtml(?: 1\.0)? frameset$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD XHTML 1.0 Frameset//EN"'
    dtd: '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"'
  ,
    pattern: /^xhtml 1\.1$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD XHTML 1.1//EN"'
    dtd: '"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"'
  ,
    pattern: /^xhtml basic 1\.0$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD XHTML Basic 1.0//EN"'
    dtd: '"http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic10.dtd"'
  ,
    pattern: /^xhtml basic(?: 1\.1)?$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//W3C//DTD XHTML Basic 1.1//EN"'
    dtd: '"http://www.w3.org/TR/xhtml-basic/DTD/xhtml-basic11.dtd"'
  ,
    pattern: /^xhtml mobile 1\.0$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//WAPFORUM//DTD XHTML Mobile 1.0//EN"'
    dtd: '"http://www.openmobilealliance.org/tech/DTD/xhtml-mobile10.dtd"'
  ,
    pattern: /^xhtml mobile 1\.1$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//WAPFORUM//DTD XHTML Mobile 1.1//EN"'
    dtd: '"http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd"'
  ,
    pattern: /^xhtml mobile(?: 1\.2)?$/i
    root: 'html'
    pi: 'PUBLIC'
    fpi: '"-//WAPFORUM//DTD XHTML Mobile 1.2//EN"'
    dtd: '"http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd"'
  ]

  constructor: ({ level, @value }) ->
    super { level, type: 'doctype' }

  @parse: (level, node) ->
    m = node.match /^<!(?:doctype|DOCTYPE)\s+(.+)$/
    return null unless m?
    # shorthands
    d = @doctypes.filter((i) -> m[1].match i.pattern)[0]
    if d?
      value = [d.root, d.pi, d.fpi, d.dtd].join(' ').trim()
      return new Doctype { level, value }
    # custom doctype
    m = m[1].match /^(?:html|HTML)\s+(?:PUBLIC|SYSTEM)\s+.*$/
    if m?
      new Doctype { level, value: m[0] }
    else
      throw new Error 'invalid doctype'

  write: ({ demo }) ->
    if demo
      indent = [0...@level].map((i) -> ' ').join ''
      "#{indent}<!DOCTYPE #{@value}>\n"
    else
      "<!DOCTYPE #{@value}>"

module.exports.Doctype = Doctype
