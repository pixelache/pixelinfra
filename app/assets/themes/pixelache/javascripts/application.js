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
function toggleNavMenu(div, linklevel) {
  
  $(div).parent().parent().children('li').children('a').css('color', '');
  for(var i = (linklevel + 1); i < 4; i++ ) {
    $("#nav_column_" + i).children('ul.navhide').css('display', 'none');
  }
  $(div + "_menu").parent('.columns').children('ul.navhide').css('display', 'none');
  $(div + "_menu").parent('.columns').children('ul.navhide').removeClass('open');
  //$(div + "_menu").parents('.columns').siblings().children('ul.navhide').css('display', 'none');

  $(div + "_menu").css('display', 'block');
  
}