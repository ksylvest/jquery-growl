###
jQuery Growl
Copyright 2013 Kevin Sylvestre
###

"use strict"

$ = jQuery

class Animation
  @transitions:
    "webkitTransition": "webkitTransitionEnd"
    "mozTransition": "mozTransitionEnd"
    "msTransition": "msTransitionEnd"
    "oTransition": "oTransitionEnd"
    "transition": "transitionend"

  @transition: ($el) ->
    el = $el[0]
    return result for type, result of @transitions when el.style[type]?

class Growl

  @settings:
    namespace: 'growl'
    duration: 3200
    close: "&times;"
    location: "default"
    style: "default"
    size: "medium"

  @growl: (settings = {}) ->
    @initialize()
    new Growl(settings)

  @initialize: ->
    $("body:not(:has(#growls))").append '<div id="growls" />'

  constructor: (settings = {}) ->
    @settings = $.extend {}, Growl.settings, settings
    @$growls().attr 'class', @settings.location
    @render()

  render: =>
    @$growls().append @$template()
    @cycle()
    return

  cycle: ->
    @$template()
      .queue(@present)
      .delay(@settings.duration)
      .queue(@dismiss)
      .queue(@remove)

  present: (callback) =>
    $template = 
    @animate(@$template(), "#{@settings.namespace}-incoming", 'out', callback)

  dismiss: (callback) =>
    @animate(@$template(), "#{@settings.namespace}-outgoing", 'in', callback)

  remove: (callback) =>
    @$template().remove()
    callback()

  animate: ($element, name, direction = 'in', callback) =>
    transition = Animation.transition($element)
    $element[if direction is 'in' then 'removeClass' else 'addClass'](name)
    $element.offset().position
    $element[if direction is 'in' then 'addClass' else 'removeClass'](name)
    return unless callback?
    if transition? then $element.one(transition, callback) else callback()
    return

  $growls: =>
    @$_growler ?= $('#growls')

  $template: =>
    @$_template ?= $(@template())

  template: =>
    """
      <div class='#{@settings.namespace} #{@settings.namespace}-#{@settings.style} #{@settings.namespace}-#{@settings.size}'>
        <div class='#{@settings.namespace}-close'>#{@settings.close}</div>
        <div class='#{@settings.namespace}-title'>#{@settings.title}</div>
        <div class='#{@settings.namespace}-message'>#{@settings.message}</div>
      </div>
    """

$.growl = (options = {}) ->
  Growl.growl(options)

$.growl.error = (options = {}) ->
  settings =
    title: "Error!"
    style: "error"

  $.growl $.extend(settings, options)

$.growl.notice = (options = {}) ->
  settings =
    title: "Notice!"
    style: "notice"

  $.growl $.extend(settings, options)

$.growl.warning = (options = {}) ->
  settings =
    title: "Warning!"
    style: "warning"

  $.growl $.extend(settings, options)
