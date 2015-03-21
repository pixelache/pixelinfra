//= require pixelache/javascripts/jstree.min
//= require pixelache/javascripts/jquery.clearfield
//= require chosen-jquery
function up_pixelache_menu() {

  $('.pixelache_nav_menu').slideUp(1000, function() {
    if ( $('.page_tree').length ) {
      $('.page_tree').css('top', '40px');
    }
    if ( $('div.project_tree').length ) {
      $('div.project_tree').css('top', '69px');
    }
    
  });
  // $('.page_tree').animate({top: '40px'}, 400);
  // $('div.project_tree').animate({top: '69px'}, 400);
  // $('#main').css('top', '80px');
}



function down_pixelache_menu() {
  var mainstart = parseInt($('#main').offset().top);
  var menuheight = parseInt($('.pixelache_nav_menu').css('height'));
  var mainfinish = 40 + menuheight;
  if ( $('.page_tree').length ) {
    // $('.page_tree').removeClass('sticky');
    // $('.page_tree').removeClass('fixed');
    var pagedest = parseInt(40 + menuheight);
    $('.page_tree').animate({top: pagedest}, 1000);
    mainfinish += parseInt($('.page_tree').height());

  }
  if ( $('div.project_tree').length ) {
    // $('div.project_tree').removeClass('sticky');
    // $('div.project_tree').removeClass('fixed');
    var projdest = parseInt(40 + menuheight + $('.page_tree').height()  + 16);
    $('div.project_tree').animate( {top: projdest}, 1000);
    mainfinish += parseInt($('div.project_tree').height());
  }
  

  
  $('.pixelache_nav_menu').slideDown(1000, function( ) {
    var start =  + 40 ;
    if ( $('.page_tree').length ) {

      $('.page_tree').addClass('fixed');
      //$('.page_tree').css('top', start);
    }
    if ( $('div.project_tree').length ) {
      $('div.project_tree').addClass('fixed');
      //$('div.project_tree').css('top', start + parseInt($('.page_tree').css('height')));
    }
    $('.pixelache_nav_menu, .top-bar-wrapper').addClass('fixed');
    if ($(window).scrollTop() == 0) {
      $('#main').css('top', mainstart);
    }

  });
  
  $(window).scroll(function() {
    if ($(window).scrollTop() == 0) {
      $('#main').css('top', 40);
    }
  });

}
function down_festival_menu() {

  // var t = parseInt($('.pixelache_nav_menu').css('height'));
  // $('.page_tree').addClass('fixed');
  // $('div.project_tree').addClass('fixed');
  // $('.festival_main_menu').slideDown();
  // $('.top-bar-wrapper').addClass('fixed');
  $('.pixelache_nav_menu').slideDown();
  //
  //
  // $('.page_tree').animate({top: (t + 40) + 'px'}, 400);
  // $('div.project_tree').animate({top: (t + 69) + 'px'}, 400);
  // $('#main').css('top', $('header').height());
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

  

function up_festival_menu() {

  $('.festival_main_menu').slideUp();

  $('#main').css('top', '70px');
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
    $(".nav_column_" + i).children('.navhide').css('display', 'none');
  }
  $(div + "_menu").parent('.columns').children('.navhide').css('display', 'none');
  $(div + "_menu").parent('.columns').children('.navhide').removeClass('open');
  //$(div + "_menu").parents('.columns').siblings().children('ul.navhide').css('display', 'none');

  $(div + "_menu").css('display', 'block');
  
}