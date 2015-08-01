assert = require 'power-assert'
bHtml = require '../src/'

describe 'Comment', ->
  it 'works', ->
    html = bHtml '''
      <!DOCTYPE html>
    '''
    assert html is '''
      <!DOCTYPE html>
    '''

    html = bHtml '''
      <!-- abc -->
    '''
    assert html is '''
      <!-- abc -->
    '''

    html = bHtml '''
      <!-- abc -->
      <!-- def -->
    '''
    assert html is '''
      <!-- abc -->
      <!-- def -->
    '''

    html = bHtml '''
      <!-- abc -->
        <!-- def -->
    '''
    assert html is '''
      <!-- abc -->
        <!-- def -->
    '''

    html = bHtml '''
      <!-- abc -->
        <!-- def -->
        <!-- ghi -->
    '''
    assert html is '''
      <!-- abc -->
        <!-- def -->
        <!-- ghi -->
    '''
