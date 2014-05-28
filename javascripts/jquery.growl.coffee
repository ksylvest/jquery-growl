###
jQuery Growl
Copyright 2013 Kevin Sylvestre
1.1.8
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

  @_growlings: []

  @_add: (growling) ->
      index = @_growlings.length
      @_growlings.push growling
      index

  @_remove: (index) ->
      @_growlings.splice index, 1

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
    $growl = @$growl()
    @$growls().append $growl
    if @settings.static? then @present() else @cycle()
    @index = Growl._add @;
    return

  bind: ($growl = @$growl()) =>
    $growl.on("contextmenu", @close).find(".#{@settings.namespace}-close").on("click", @close)

  unbind: ($growl = @$growl()) =>
    $growl.off("contextmenu", @close).find(".#{@settings.namespace-close}").off("click", @close)

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
    queue = $growl
            .queue(@present)

    if false != @settings.duration    
      queue
        .delay(@settings.duration)
        .queue(@dismiss)
        .queue(@remove)

    queue

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
    Growl._remove @index
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

$.growl.removeAll = ->
  $.growl.remove growling for growling in Growl._growlings    
  return

$.growl.remove = (growling) ->
  growling.$growl()
      .queue(growling.dismiss)
      .queue(growling.remove)
  return
