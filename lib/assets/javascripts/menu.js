jQuery(function($){
  var $start_menu = $("#sidemenu");
  var $menu_ul = $("#menu");
  var pathname = window.location.pathname,
      hash = window.location.hash,
      namespace = pathname.split('/')[1],
      current_menu = {
    "xianchang": "xianchang",
          "pos": "shouyin",
          "crm": "kehu",
     "xiaoshou": "xiaoshou",
        "kucun": "kucun",
          "soa": "yuangong",
          "ais": "caiwu",
          "sas": "tongji",
     "settings": "shezhi",
      },
      first_nav = $("." + current_menu[namespace]).parent("li"),
      second_nav = $("a[href='" + pathname + hash + "']").parent("li");

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

  var original_nav = function(){
    $(first_nav).addClass("hover");
    $(second_nav).addClass("hover");
    $("#" + current_menu[namespace]).show()
                                  .siblings(".sec_menu").hide();
  }
  original_nav();

  $start_menu.on('mouseleave', function(){
    original_nav();
  })


});
