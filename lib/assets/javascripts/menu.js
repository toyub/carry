jQuery(function($){
  var $start_menu = $("#menu");
  $("#menutoggle").on("click", function(event){
    event.stopPropagation();
    $start_menu.toggle();
    $("#menutoggle").parents(".top_left").toggleClass('open')

  });

  $("#menu").on("click", function(event){
    event.stopPropagation();
  });

  $(document).on("click", function(){
    $start_menu.hide();
    $("#menutoggle").parents(".top_left").removeClass('open')
  });
});
