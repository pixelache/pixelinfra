//= require pixelache/javascripts/jstree.min
//= require pixelache/javascripts/jquery.clearfield
//= require chosen-jquery

function down_pixelache_menu() {

  var t = parseInt($('.pixelache_nav_menu').css('height'));
  $('.pixelache_nav_menu').slideDown();
  $('.page_tree').animate({top: (t + 40) + 'px'}, 400);
  $('div.project_tree').animate({top: (t + 69) + 'px'}, 400);
  
}


function load_to_top(href) {
  var freezeheight = $('.multipost_selected').css('height');
  $('.multipost_selected').css('height', freezeheight);
  $('.top_post').fadeOut();
  $('.multipost_selected').load(href, function() {
    $('.multipost_selected').css('height', '');
    maps = initialize();
  });
  
}

  
function up_pixelache_menu() {

  $('.pixelache_nav_menu').slideUp();
  $('.page_tree').animate({top: '40px'}, 400);

}

function toggleWideNavMenu(div, linklevel) {
  
  $(div).parent().parent().children('li').children('a').css('color', '');
  $(div + "_menu").children('ul.navhide').css('display', 'block');
  
  $(div + "_menu").parent('.columns').children('ul.navhide').css('display', 'none');
  $(div + "_menu").parent('.columns').children('ul.navhide').removeClass('open');
  //$(div + "_menu").parents('.columns').siblings().children('ul.navhide').css('display', 'none');

  $(div + "_menu").css('display', 'block');
  
}


function toggleNavMenu(div, linklevel) {
  
  $(div).parent().parent().children('li').children('a').css('color', '');
  for(var i = (linklevel + 1); i < 4; i++ ) {
    $(".nav_column_" + i).children('ul.navhide').css('display', 'none');
  }
  $(div + "_menu").parent('.columns').children('ul.navhide').css('display', 'none');
  $(div + "_menu").parent('.columns').children('ul.navhide').removeClass('open');
  //$(div + "_menu").parents('.columns').siblings().children('ul.navhide').css('display', 'none');

  $(div + "_menu").css('display', 'block');
  
}