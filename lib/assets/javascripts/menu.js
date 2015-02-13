jQuery(function($){
  var $start_menu = $("#start_menu");
  var $primary_menu = $("#primary");
  $("#menutoggle").on("click", function(){
      $start_menu.toggle();
  });

  $start_menu.on("mouseenter", '#primary > li > a', function(evt){
    $("#submenus > div.hover").removeClass('hover');
    $(this.hash).addClass('hover');
  })
  
  $start_menu.on('mouseleave', function(){
    $("#submenus > div.hover").removeClass('hover');
    $($primary_menu.find('li.hover > a:first')[0].hash).addClass('hover');
  });

  $("#content").on("click", function(){
    $start_menu.hide();
  });
});