jQuery(function($){
  var $start_menu = $("#sidemenu");
  var $menu_ul = $("#menu");
  $("#menutoggle").on("click", function(){
     $start_menu.toggle();
  });

  $menu_ul.on("mouseenter", 'li > a', function(){
    $("#second_menu .sec_menu").hide();
    $("#"+this.className).show();
  });

  $("#content").on("click", function(){
    $start_menu.hide();
  });

  $(".nav_right").on("click",'li',function(){
    $(this).toggleClass("open");
    $(this).siblings().removeClass("open")
  })
});
