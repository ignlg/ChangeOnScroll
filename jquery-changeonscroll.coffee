###
  ChangeOnScroll
  https:#github.com/ignlg/ChangeOnScroll

  Copyright (c) 2015 Ignacio Lago
  MIT license
###

(($) ->

  $.isChangeOnScroll = (el) ->
    not not $(el).data 'ChangeOnScroll'

  $.ChangeOnScroll = (el, options) ->
    base = this
    base.$el = $ el
    base.el = el
    # Add a reverse reference to the DOM object.
    base.$el.data 'ChangeOnScroll', base
    # A flag so we know if the scroll has been reset.
    isReset = false
    # Who should change.
    target = base.$el
    # Who fires the change when scrolled above the top of the page.
    reference = target
    # The offset top of the element when resetScroll was called.
    offsetTop = 0
    # The offset left of the element when resetScroll was called.
    offsetLeft = 0

    resetScroll = ->
      # Capture the offset top of the reference element.
      offsetTop = reference.offset().top + ( base.options.topOffset or 0 )
      # Capture the offset left of the reference element.
      offsetLeft = reference.offset().left + ( base.options.leftOffset or 0 )
      # Set that this has been called at least once.
      isReset = true

    # Checks to see if we need to do something based on new scroll position
    # of the page.
    checkScroll = ->
      if not $.isChangeOnScroll target then return
      wasReset = isReset
      # If resetScroll has not yet been called, call it. This only
      # happens once.
      if not isReset
        resetScroll()
      else
        # Capture the offset top of the reference element.
        offsetTop = reference.offset().top + ( base.options.topOffset or 0 )
        # Capture the offset left of the reference element.
        offsetLeft = reference.offset().left + ( base.options.leftOffset or 0 )

      # Grab the current horizontal scroll position.
      x = $(window).scrollLeft()
      # Grab the current vertical scroll position.
      y = $(window).scrollTop()
      # If the vertical or horizontall scroll position, plus the
      # optional offsets, would put the reference element above the top
      # of the page, set the class to the target element.
      if (base.options.verticalScroll and y > offsetTop) or
      ( base.options.horizontalScroll and x > offsetLeft)
        target.addClass base.options.className
      else
        target.removeClass base.options.className

    windowResize = (event) ->
      isReset = false
      checkScroll()

    windowScroll = (event) ->
      if not not window.requestAnimationFrame
        window.requestAnimationFrame(checkScroll)
      else checkScroll()

    preventDefault = (e) ->
      e = e or window.event
      if e.preventDefault
        e.preventDefault()
      e.returnValue = false
      return

    # Initializes this plugin. Captures the options passed in and binds
    # to the window scroll and resize events.

    base.init = ->
      # Capture the options for this plugin.
      base.options = $.extend {}, $.ChangeOnScroll.defaultOptions, options

      if base.options.reference
        reference = $ base.options.reference

      # Reset the reference element offsets when the window is resized, then
      # check to see if we need to toggle the target element class.
      $(window).bind 'resize.ChangeOnScroll', windowResize
      # Same for scroll.
      $(window).bind 'scroll.ChangeOnScroll', windowScroll
      # For touch devices.
      if 'ontouchmove' of window
        $(window).bind 'touchmove.ChangeOnScroll', checkScroll

      reference.bind 'scroll.ChangeOnScroll', -> checkScroll()

      reference.bind 'detach.ChangeOnScroll', (ev) ->
        preventDefault ev
        $(window).unbind 'resize.ChangeOnScroll', windowResize
        $(window).unbind 'scroll.ChangeOnScroll', windowScroll
        reference.unbind '.ChangeOnScroll'
        base.$el.removeData 'ChangeOnScroll'

      # Reset everything.
      windowResize()

    # Initialize the plugin.
    base.init()

  # Sets the option defaults.
  $.ChangeOnScroll.defaultOptions =
    topOffset: 0
    leftOffset: 0
    verticalScroll: true
    horizontalScroll: true
    className: 'changed-on-scroll'

  $.fn.changeOnScroll = (options) ->
    @each -> new ($.ChangeOnScroll)(this, options)

  return
) jQuery
