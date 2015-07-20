// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery-ui/autocomplete
//= require autocomplete-rails
//= require jquery-ui/sortable
//= require foundation
//= require jquery_nested_form
//= require ckeditor/init
//= require jquery.slick
//= require lazybox
//= require_tree .

  ;(function ($, window, document, undefined) {
    'use strict';

    Foundation.libs['magellan-expedition'] = {
      name : 'magellan-expedition',

      version : '5.4.6',

      settings : {
        active_class: 'active',
        threshold: 0, // pixels from the top of the expedition for it to become fixes
        // Changelog - more threshold from top
        destination_threshold: 61, // pixels from the top of destination for it to be considered active
        throttle_delay: 30, // calculation throttling to increase framerate
        fixed_top: 0 // top distance in pixels assigend to the fixed element on scroll
      },

      init : function (scope, method, options) {
        Foundation.inherit(this, 'throttle');
        this.bindings(method, options);
      },

      events : function () {
        var self = this,
            S = self.S,
            settings = self.settings;

        // initialize expedition offset
        self.set_expedition_position();

        S(self.scope)
          .off('.magellan')
          .on('click.fndtn.magellan', '[' + self.add_namespace('data-magellan-arrival') + '] a[href^="#"]', function (e) {
            e.preventDefault();
            var expedition = $(this).closest('[' + self.attr_name() + ']'),
                settings = expedition.data('magellan-expedition-init'),
                hash = this.hash.split('#').join(''),
                target = $("a[name='"+hash+"']");

            if (target.length === 0) {
              target = $('#'+hash);
            }

            var scroll_top = target.offset().top - settings.destination_threshold + 1;
            // Changelog - Account for expedition height if fixed position
            //scroll_top = scroll_top - expedition.outerHeight();

            $('html, body').stop().animate({
              'scrollTop': scroll_top
            }, 700, 'swing', function () {
              if(history.pushState) {
                history.pushState(null, null, '#'+hash);
              }
              else {
                location.hash = '#'+hash;
              }
            });
          })
          .on('scroll.fndtn.magellan', self.throttle(this.check_for_arrivals.bind(this), settings.throttle_delay));

        $(window)
          .on('resize.fndtn.magellan', self.throttle(this.set_expedition_position.bind(this), settings.throttle_delay));
      },

      check_for_arrivals : function() {
        var self = this;
        self.update_arrivals();
        self.update_expedition_positions();
      },

      set_expedition_position : function() {
        var self = this;
        $('[' + this.attr_name() + '=fixed]', self.scope).each(function(idx, el) {
          var expedition = $(this),
              settings = expedition.data('magellan-expedition-init'),
              styles = expedition.attr('styles'), // save styles
              top_offset, fixed_top;

          expedition.attr('style', '');
          top_offset = expedition.offset().top + settings.threshold;

          //set fixed-top by attribute
          fixed_top = parseInt(expedition.data('magellan-fixed-top'));
          if(!isNaN(fixed_top))
              self.settings.fixed_top = fixed_top;

          expedition.data(self.data_attr('magellan-top-offset'), top_offset);
          expedition.attr('style', styles);
        });
      },

      update_expedition_positions : function() {
        var self = this,
            window_top_offset = $(window).scrollTop();

        $('[' + this.attr_name() + '=fixed]', self.scope).each(function() {
          var expedition = $(this),
              settings = expedition.data('magellan-expedition-init'),
              styles = expedition.attr('style'), // save styles
              top_offset = expedition.data('magellan-top-offset');
        
          //scroll to the top distance
          if (window_top_offset+self.settings.fixed_top >= top_offset) {

            // Placeholder allows height calculations to be consistent even when
            // appearing to switch between fixed/non-fixed placement
            var placeholder = expedition.prev('[' + self.add_namespace('data-magellan-expedition-clone') + ']');
            if (placeholder.length === 0) {
              placeholder = expedition.clone();
              placeholder.removeAttr(self.attr_name());
              placeholder.attr(self.add_namespace('data-magellan-expedition-clone'),'');
              expedition.before(placeholder);
            }
            // Changelog - Adding expedition stop point so it can't overlap elements below last destination
            var lastDestination = $("[data-magellan-destination]:last-child"); // Cache last destination (ld)
            var ldBottom = lastDestination.offset().top + lastDestination.height(); // Calculate offset bottom of ld
            var ldBottomYPosition = (ldBottom-window_top_offset); // Calculate ld bottom position

            // If expedition bottom passes ld bottom
            //alert('ldBottomYPosition is ' + ldBottomYPosition + ' and expedition.height() is ' + expedition.height() + ' and settings.destination_threshold is ' + settings.destination_threshold);
            if(ldBottomYPosition <= (expedition.height() + settings.destination_threshold)) {

              // Position expedition top so bottom lines up with last destination
              // For different behavior, replace next line with your code
              expedition.css({position:'fixed', top: ldBottomYPosition - expedition.height(), minWidth: 0, width: expedition.outerWidth() + 'px'});
              
            } else {

              // Magellan as .side-nav width fix: http://foundation.zurb.com/forum/posts/13831-fixed-sidebar
              expedition.css({position:'fixed', top: settings.fixed_top, minWidth: 0, width: expedition.outerWidth() + 'px'});
            }
          } else {
            expedition.prev('[' + self.add_namespace('data-magellan-expedition-clone') + ']').remove();
            expedition.attr('style',styles).css('position','').css('top','').removeClass('fixed');
          }
        });
      },

      update_arrivals : function() {
        var self = this,
            window_top_offset = $(window).scrollTop();

        $('[' + this.attr_name() + ']', self.scope).each(function() {
          var expedition = $(this),
              settings = expedition.data(self.attr_name(true) + '-init'),
              offsets = self.offsets(expedition, window_top_offset),
              arrivals = expedition.find('[' + self.add_namespace('data-magellan-arrival') + ']'),
              active_item = false;
          offsets.each(function(idx, item) {
            if (item.viewport_offset >= item.top_offset) {
              var arrivals = expedition.find('[' + self.add_namespace('data-magellan-arrival') + ']');
              arrivals.not(item.arrival).removeClass(settings.active_class);
              item.arrival.addClass(settings.active_class);
              active_item = true;
              return true;
            }
          });

          if (!active_item) arrivals.removeClass(settings.active_class);
        });
      },

      offsets : function(expedition, window_offset) {
        var self = this,
            settings = expedition.data(self.attr_name(true) + '-init'),
            viewport_offset = window_offset;

        return expedition.find('[' + self.add_namespace('data-magellan-arrival') + ']').map(function(idx, el) {
          var name = $(this).data(self.data_attr('magellan-arrival')),
              dest = $('[' + self.add_namespace('data-magellan-destination') + '=' + name + ']');
          if (dest.length > 0) {

            // Changelog - Removing sidebar compensation, default commented
            // var top_offset = Math.floor(dest.offset().top - settings.destination_threshold - expedition.outerHeight());
            var top_offset = Math.floor(dest.offset().top - settings.destination_threshold);

            return {
              destination : dest,
              arrival : $(this),
              top_offset : top_offset,
              viewport_offset : viewport_offset
            }
          }
        }).sort(function(a, b) {
          if (a.top_offset < b.top_offset) return -1;
          if (a.top_offset > b.top_offset) return 1;
          return 0;
        });
      },

      data_attr: function (str) {
        if (this.namespace.length > 0) {
          return this.namespace + '-' + str;
        }

        return str;
      },

      off : function () {
        this.S(this.scope).off('.magellan');
        this.S(window).off('.magellan');
      },

      reflow : function () {
        var self = this;
        // remove placeholder expeditions used for height calculation purposes
        $('[' + self.add_namespace('data-magellan-expedition-clone') + ']', self.scope).remove();
      }
    };
  }(jQuery, window, window.document));



$(function(){ $(document).foundation(); 
  $('a[rel*=lazybox]').lazybox({overlay: true, esc: true, close: true, modal: true});
  $('.datetime_picker').fdatetimepicker({
      format: 'yyyy-mm-dd hh:ii'
  });
  $('.date_picker').fdatetimepicker({
      format: 'yyyy-mm-dd'
  });
});


function scrollTo(target) { 

  $('html, body').stop().animate({
      'scrollTop': $(target).offset().top - 40
  }, 900, 'swing', function () {
      //window.location.hash = target;
  });
  return false;
}

