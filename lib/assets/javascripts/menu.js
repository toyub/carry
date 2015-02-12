jQuery(function($){
  var $sidemenu = $("#sidemenu");
  var $menu = $("#menu");
  $("#menutoggle").on("click", function(){
      $sidemenu.toggle();
  });


  var _side_bar = {
    validate: function(attrs, options) {
      if(!!attrs.color){
        if(color != 'black') return 'Wrong color!';
      }
      
    },
    promptColor: function() {
      this.set({color: "#333333"});
    }
  };

  var Sidebar = Backbone.Model.extend(_side_bar);

  window.sidebar = new Sidebar;

  sidebar.on('change:color', function(model, color) {
    $('#sidemenu').css({background: color});
  });

  sidebar.set({color: 'white'});

  sidebar.promptColor();
  sidebar.on("invalid", function(model, error) {
    console.log(model.get("title") + " " + error);
  });

  $sidemenu.on("mouseenter", '#menu > li > a', function(evt){
    $("#submenu > div.hover").removeClass('hover');
    $(this.hash).addClass('hover');
  })
  
  $sidemenu.on('mouseleave', function(){
    $("#submenu > div.hover").removeClass('hover');
    $($menu.find('li.hover > a:first')[0].hash).addClass('hover');
  });

  $("#content").on("click", function(){
    $sidemenu.hide();
  });
});