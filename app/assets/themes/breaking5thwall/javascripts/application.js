//= require jquery2
//= require jquery_ujs
//= require jquery-ui/core
function toggleEvent(d) {
  $('.event_link' + d).fadeIn();
  $('.event_link').not(d).fadeOut();
  $('.filters ul li').removeClass('active');
  if ($('.event_link' + d).css('display') != "none") {

    $('.filters ul li' + d).addClass('active');
  }
}
$(document).ready(function() {

  // Check for click events on the navbar burger icon
  $(".navbar-burger").click(function() {

      // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
      $(".navbar-burger").toggleClass("is-active");
      $(".navbar-menu").toggleClass("is-active");

  });

  
});