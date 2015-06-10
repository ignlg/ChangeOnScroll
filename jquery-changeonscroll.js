
/*
  ChangeOnScroll
  https:#github.com/ignlg/ChangeOnScroll

  Copyright (c) 2015 Ignacio Lago
  MIT license
 */
(function($) {
  $.isChangeOnScroll = function(el) {
    return !!$(el).data('ChangeOnScroll');
  };
  $.ChangeOnScroll = function(el, options) {
    var base, checkScroll, isReset, offsetLeft, offsetTop, preventDefault, reference, resetScroll, target, windowResize, windowScroll;
    base = this;
    base.$el = $(el);
    base.el = el;
    base.$el.data('ChangeOnScroll', base);
    isReset = false;
    target = base.$el;
    reference = target;
    offsetTop = 0;
    offsetLeft = 0;
    resetScroll = function() {
      offsetTop = reference.offset().top + (base.options.topOffset || 0);
      offsetLeft = reference.offset().left + (base.options.leftOffset || 0);
      return isReset = true;
    };
    checkScroll = function() {
      var wasReset, x, y;
      if (!$.isChangeOnScroll(target)) {
        return;
      }
      wasReset = isReset;
      if (!isReset) {
        resetScroll();
      } else {
        offsetTop = reference.offset().top + (base.options.topOffset || 0);
        offsetLeft = reference.offset().left + (base.options.leftOffset || 0);
      }
      x = $(window).scrollLeft();
      y = $(window).scrollTop();
      if ((base.options.verticalScroll && y > offsetTop) || (base.options.horizontalScroll && x > offsetLeft)) {
        return target.addClass(base.options.className);
      } else {
        return target.removeClass(base.options.className);
      }
    };
    windowResize = function(event) {
      isReset = false;
      return checkScroll();
    };
    windowScroll = function(event) {
      if (!!window.requestAnimationFrame) {
        return window.requestAnimationFrame(checkScroll);
      } else {
        return checkScroll();
      }
    };
    preventDefault = function(e) {
      e = e || window.event;
      if (e.preventDefault) {
        e.preventDefault();
      }
      e.returnValue = false;
    };
    base.init = function() {
      base.options = $.extend({}, $.ChangeOnScroll.defaultOptions, options);
      if (base.options.reference) {
        reference = $(base.options.reference);
      }
      $(window).bind('resize.ChangeOnScroll', windowResize);
      $(window).bind('scroll.ChangeOnScroll', windowScroll);
      if ('ontouchmove' in window) {
        $(window).bind('touchmove.ChangeOnScroll', checkScroll);
      }
      reference.bind('scroll.ChangeOnScroll', function() {
        return checkScroll();
      });
      reference.bind('detach.ChangeOnScroll', function(ev) {
        preventDefault(ev);
        $(window).unbind('resize.ChangeOnScroll', windowResize);
        $(window).unbind('scroll.ChangeOnScroll', windowScroll);
        reference.unbind('.ChangeOnScroll');
        return base.$el.removeData('ChangeOnScroll');
      });
      return windowResize();
    };
    return base.init();
  };
  $.ChangeOnScroll.defaultOptions = {
    topOffset: 0,
    leftOffset: 0,
    verticalScroll: true,
    horizontalScroll: true,
    className: 'changed-on-scroll'
  };
  $.fn.changeOnScroll = function(options) {
    return this.each(function() {
      return new $.ChangeOnScroll(this, options);
    });
  };
})(jQuery);
