//= require jquery2
//= require jquery_ujs
//= require jquery-ui/core
//= require foundation
//= require jquery.infinite-pages
//= require empathy/javascripts/jquery.mCustomScrollbar.concat.min
 $( function() {

   $(document).foundation();

});

function toggleEvent(d) {
  $('.event_link' + d).fadeIn();
  $('.event_link').not(d).fadeOut();
  $('.filters ul li').removeClass('active');
  if ($('.event_link' + d).css('display') != "none") {

    $('.filters ul li' + d).addClass('active');
  }
}