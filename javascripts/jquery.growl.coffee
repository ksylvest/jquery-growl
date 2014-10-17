###
jQuery Growl
Copyright 2013 Kevin Sylvestre
1.2.4
###

"use strict"

$ = jQuery

class Animation
  @transitions:
    "webkitTransition": "webkitTransitionEnd"
    "mozTransition": "mozTransitionEnd"
    "oTransition": "oTransitionEnd"
    "transition": "transitionend"

  @transition: ($el) ->
    el = $el[0]
    return result for type, result of @transitions when el.style[type]?

class Growl

  @settings:
    namespace: 'growl'
    duration: 3200
    close: "&#215;"
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
    $growl = @$growl()
    @$growls().append $growl
    if @settings.static? then @present() else @cycle()
    return

  bind: ($growl = @$growl()) =>
    $growl.on("contextmenu", @close).find(".#{@settings.namespace}-close").on("click", @close)

  unbind: ($growl = @$growl()) =>
    $growl.off("contextmenu", @close).find(".#{@settings.namespace}-close").off("click", @close)

  close: (event) =>
    event.preventDefault()
    event.stopPropagation()
    $growl = @$growl()
    $growl
      .stop()
      .queue(@dismiss)
      .queue(@remove)

  cycle: =>
    $growl = @$growl()
    $growl
      .queue(@present)
      .delay(@settings.duration)
      .queue(@dismiss)
      .queue(@remove)

  present: (callback) =>
    $growl = @$growl()
    @bind($growl)
    @animate($growl, "#{@settings.namespace}-incoming", 'out', callback)

  dismiss: (callback) =>
    $growl = @$growl()
    @unbind($growl)
    @animate($growl, "#{@settings.namespace}-outgoing", 'in', callback)

  remove: (callback) =>
    @$growl().remove()
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
    @$_growls ?= $('#growls')

  $growl: =>
    @$_growl ?= $(@html())

  html: =>
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
