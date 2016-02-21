//= require pixelache/javascripts/jstree.min
//= require pixelache/javascripts/jquery.clearfield

//= require chosen-jquery
function up_pixelache_menu() {
  var mainfinish = 0;
  if ( $('.page_tree').length ) {
    $('.page_tree').animate({top: 40}, 1000);
    mainfinish += parseInt($('.page_tree').height());
  }
  if ( $('div.project_tree').length ) {
    $('div.project_tree').animate({top: 69}, 1000);
    mainfinish += parseInt($('.project_tree').height());
  }
  // $('#main').animate({top: 40}, 1000);
  // 
  console.log('mainfinish is ' + mainfinish);
  $('#main').animate({ top: mainfinish   }, 1000);
  $('.pixelache_nav_menu').slideUp(1000, function() {
    $('#main').css('top', mainfinish + 40 );
    $(window).scroll(function() {
      if ($(window).scrollTop() == 0) {
        $('#main').css('top', mainfinish );
      }
    });
  });
  // $('.page_tree').animate({top: '40px'}, 400);
  // $('div.project_tree').animate({top: '69px'}, 400);
  // $('#main').css('top', '80px');
}



function down_pixelache_menu() {
  var mainstart = parseInt($('#main').offset().top);
  var menuheight = parseInt($('.pixelache_nav_menu').css('height'));
  var mainfinish = menuheight;
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
  // console.log('mainfinish is ' + mainfinish);
  $('#main').animate({ top: mainfinish   }, 1000);
  
  $('.pixelache_nav_menu').slideDown(1000, function( ) {
    if ( $('.page_tree').length ) {
      $('.page_tree').addClass('fixed');
    }
    if ( $('div.project_tree').length ) {
      $('div.project_tree').addClass('fixed');
      
    }
    $('.pixelache_nav_menu, .top-bar-wrapper').addClass('fixed');
    $('#main').css('top', mainfinish + 40 );
  });
  
  $(window).scroll(function() {
    if ($(window).scrollTop() == 0) {
      $('#main').css('top', mainfinish);
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
  $('.multipost_selected .top_post').fadeOut();
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
  for(var i = (linklevel + 1); i < 4; i++ ) {
    $(".nav_column_" + i).children('.navhide').css('display', 'none');
  }
  $(div + "_menu").children('ul.navhide').css('display', 'block');
  
  $(div + "_menu").parent('.columns').children('ul.navhide').css('display', 'none');
  $(div + "_menu").parent('.columns').children('ul.navhide').removeClass('open');
  //$(div + "_menu").parents('.columns').siblings().children('ul.navhide').css('display', 'none');

  $(div + "_menu").css('display', 'block');
  
}

function reset_mobile_menu() {
  $('ul.first').slideDown().removeClass('rolled');
  $('.navhide').css('display', 'none');
  $('.festival_menu ul').removeClass('open');
  $('.nav_column_1, .nav_column_2, .nav_column_3').css('border-bottom', 'none');
}

function toggleNavMenu(div, linklevel) {
 
  $(div).parent().parent().children('li').children('a').css('color', '');
  for(var i = (linklevel + 1); i < 4; i++ ) {
    $(".nav_column_" + i).children('.navhide:not(.open)').css('display', 'none');
  }
  $('ul.first').addClass('rolled');
  $(div + "_menu").parent().next('.columns').children('ul.navhide').css('display', 'none');
  $(div + "_menu").parent('.columns').children('.navhide').css('display', 'none');
  //$(div + "_menu").parent('.columns').children('.navhide').removeClass('open');
  //$(div + "_menu").parents('.columns').siblings().children('ul.navhide').css('display', 'none');


  $(div).parents('ul').find('li a').removeClass('active');
  $(div).addClass('active');
  
  if(!!('ontouchstart' in window)) {

    $('ul.rolled').slideUp();
    $(div).parents('ul').find('li :not(a.active)').parent('li').css('display', 'none');
    $(div + "_menu").css('display', 'block');
    $('.festival_menu .festival_top_header .menu_reset').css('display', 'inline');
    // $(".nav_column_" + parseInt(linklevel + 1));
    $('.festival_main_menu').css('height', 'auto');
    $('.nav_column_' + linklevel + ' ul').css('height', 'auto')

  }
  else {
    for(var i = (linklevel + 1); i < 4; i++ ) {
      $(".nav_column_" + i).children('.navhide').css('display', 'none');
    }
  }

  $(div + "_menu li").css('display', 'block');
  $(div + "_menu").css('display', 'block');
}