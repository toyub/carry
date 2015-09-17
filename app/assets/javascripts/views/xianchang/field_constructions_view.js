Mis.Views.FieldConstructionsView = Backbone.View.extend({
  el:  ".js-waiting-vehicle",
  initialize: function(){
    var _this = this;
    store_orders = new Mis.Collections.StoreOrders;
    this.collection = store_orders;

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
  }
})

$(function(){
  new Mis.Views.FieldConstructionsView()
})
