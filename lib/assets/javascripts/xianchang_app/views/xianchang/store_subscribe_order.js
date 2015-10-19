Mis.Views.SubscribeOrderView = Backbone.View.extend({
  el: ".reserve_list table tbody",
  template: JST["xianchang/subscribe_order/table_item"],
  render: function(){
    var _this = this;
    this.collection.each(function(item){
      _this.$el.append(_this.template(item.attributes))
    });
    return this.$el;
  },
  initialize: function(){
    var _this = this;
    this.collection = new Mis.Collections.StoreSubscribeOrders;
    this.collection.fetch({
      success: function(){
        _this.render();
      }
    })
  }
})

$(function(){
  if($(".reserve_list table tbody").length > 0)
    new Mis.Views.SubscribeOrderView()
})
