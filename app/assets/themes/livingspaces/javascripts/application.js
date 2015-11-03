//= require jquery2
//= require jquery_ujs
//= require jquery-ui/core
//= require foundation
//= require slick
 

function myScroll(target) { 

  $('html, body').stop().animate({
      'scrollTop': $(target).offset().top - 40
  }, 900, 'swing', function () {
      //window.location.hash = target;
  });
  return false;
}

$(function(){ 
  $(document).foundation(); 
});