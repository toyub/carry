Mis.Views.SubscribeOrderView = Backbone.View.extend({
  el: ".reserve_list table tbody",
  template: JST["xianchang/subscribe_order/table_item"],
  render: function(){
    var _this = this;
    this.collection.each(function(item){
      _this.$el.append(_this.template(item.attributes))
    });
    console.log("here done");
    return this.$el;
  },
  initialize: function(){
    var _this = this;
    console.log("mousehi sier")
    this.collection = new Mis.Collections.StoreSubscribeOrders;
    window.mouse = this.collection;
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
