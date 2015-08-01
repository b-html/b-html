assert = require 'power-assert'
bHtml = require '../src/'

describe 'Element', ->
  it 'works', ->
    html = bHtml '''
      <p
    '''
    assert html is '''
      <p>
      </p>
    '''

    html = bHtml '''
      <p
      <p
    '''
    assert html is '''
      <p>
      </p>
      <p>
      </p>
    '''

    html = bHtml '''
      <p
        <p
    '''
    assert html is '''
      <p>
        <p>
        </p>
      </p>
    '''

    html = bHtml '''
      <p
        <p
        <p
    '''
    assert html is '''
      <p>
        <p>
        </p>
        <p>
        </p>
      </p>
    '''
