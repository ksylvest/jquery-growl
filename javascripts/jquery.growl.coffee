###
jQuery Growl
Copyright 2015 Kevin Sylvestre
1.3.5
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
    delayOnHover: true

  @growl: (settings = {}) ->
    new Growl(settings)

  constructor: (settings = {}) ->
    @settings = $.extend {}, Growl.settings, settings
    @initialize(@settings.location)
    @render()

  initialize: (location) ->
    id = 'growls-' + location;
    $('body:not(:has(#' + id + '))').append '<div id="' + id + '" />'

  render: =>
    $growl = @$growl()
    @$growls(@settings.location).append $growl
    if @settings.fixed then @present() else @cycle()
    return

  bind: ($growl = @$growl()) =>
    $growl.on("click", @click)
    if(@settings.delayOnHover)
      $growl.on("mouseenter", @mouseEnter)
      $growl.on("mouseleave", @mouseLeave)
    $growl.on("contextmenu", @close).find(".#{@settings.namespace}-close").on("click", @close)

  unbind: ($growl = @$growl()) =>
    $growl.off("click", @click)
    if(@settings.delayOnHover)
      $growl.off("mouseenter", @mouseEnter)
      $growl.off("mouseleave", @mouseLeave)
    $growl.off("contextmenu", @close).find(".#{@settings.namespace}-close").off("click", @close)

  mouseEnter: (event) =>
    $growl = @$growl()
    $growl
      .stop(true,true)

  mouseLeave: (event) =>
    @waitAndDismiss()

  click: (event) =>
    if @settings.url?
      event.preventDefault()
      event.stopPropagation()
      window.open(@settings.url)

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
      .queue(@waitAndDismiss())

  waitAndDismiss: =>
    $growl = @$growl()
    $growl
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
    callback?()

  animate: ($element, name, direction = 'in', callback) =>
    transition = Animation.transition($element)
    $element[if direction is 'in' then 'removeClass' else 'addClass'](name)
    $element.offset().position
    $element[if direction is 'in' then 'addClass' else 'removeClass'](name)
    return unless callback?
    if transition? then $element.one(transition, callback) else callback()
    return

  $growls: (location) =>
    @$_growls ?= []
    @$_growls[location] ?= $('#growls-' + location)

  $growl: =>
    @$_growl ?= $(@html())

  html: =>
    @container(@content())

  content: =>
    """
    <div class='#{@settings.namespace}-close'>#{@settings.close}</div>
    <div class='#{@settings.namespace}-title'>#{@settings.title}</div>
    <div class='#{@settings.namespace}-message'>#{@settings.message}</div>
    """

  container: (content) =>
    """
    <div class='#{@settings.namespace} #{@settings.namespace}-#{@settings.style} #{@settings.namespace}-#{@settings.size}'>
      #{content}
    </div>
    """

@Growl = Growl

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
