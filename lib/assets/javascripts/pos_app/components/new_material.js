(function(win, Backbone, $, Mis){
  var tmpl =  JST["pos/orders/new_material"];

  Mis.Views.newMaterialView = function(){
    $(".list-new-material").append(tmpl());
  }
})(window, Backbone, jQuery, Mis);
