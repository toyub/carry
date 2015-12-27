jQuery(function($){
  var $start_menu = $("#sidemenu");
  var $menu_ul = $("#menu");
  var namespace = window.location.pathname.split('/')[1];
  var current_menu = {
    "xianchang": "xianchang",
          "pos": "shouyin",
          "crm": "kehu",
     "xiaoshou": "xiaoshou",
        "kucun": "kucun",
          "soa": "yuangong",
          "ais": "caiwu",
          "sas": "tongji",
     "settings": "shezhi",
  }
  $("#menutoggle").on("click", function(){
     $start_menu.toggle();
  });

  $menu_ul.on("mouseenter", 'li > a', function(){
    $("#second_menu .sec_menu").hide();
    $("#"+this.className).show();
  });

  $("#content").on("click", function(){
    if (document.body.clientWidth < 1750) {
      $start_menu.hide();
    }
  });

  $(".nav_right").on("click",'li',function(){
    $(this).toggleClass("open");
    $(this).siblings().removeClass("open")
  })

  $("#" + current_menu[namespace]).show()
                                  .siblings(".sec_menu").hide();

});
