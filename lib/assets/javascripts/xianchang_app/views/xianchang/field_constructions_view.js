Mis.Views.FieldConstructionsView = Backbone.View.extend({
  el:  ".js-waiting-vehicle",
  events: {
    'click li img':'showWrap',
  },
  initialize: function(){
    var _this = this;
    this.collection = new Mis.Collections.StoreOrders;

    this.collection.fetch({
      success: function(){
        _this.render();
      }
    });
  },
  render: function(){
    var _this = this;
    _(this.collection.models).each(function(item){
      $(_this.el).append("<li><span>" + item.attributes.store_vehicle.name + "</span><img src='/small_car.png'></img></li>");
    })
  },

  showWrap: function(){
    $("#vehicle_order_details").show();
  }
})

$(function(){
  if($(".js-waiting-vehicle").length > 0)
    new Mis.Views.FieldConstructionsView()
})
