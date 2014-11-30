//= require pixelache/javascripts/jstree.min
//= require pixelache/javascripts/jquery.clearfield
//= require chosen-jquery

function down_pixelache_menu() {

  $('.pixelache_nav_menu').slideDown();
  $('.arrow-up').css('display', 'block');


}

function up_pixelache_menu() {

  $('.pixelache_nav_menu').slideUp();
  $('.arrow-up').css('display', 'none');

}
function toggleNavMenu(div) {
  
  $(div).parent().parent().children('li').children('a').css('color', '#ccc');
  $(div).css('color', '#fff');
  $(div + "_menu").parent('.columns').children('ul.navhide').css('display', 'none');
  $(div + "_menu").css('display', 'block');
  
}