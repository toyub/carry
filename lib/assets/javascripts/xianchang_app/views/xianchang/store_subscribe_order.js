Mis.Views.SubscribeOrderView = Backbone.View.extend({
  el: ".reserve_list table tbody",
  render: function(){
    var _this = this;

    this.collection.each(function(item){
      var view = new Mis.Views.SubscribeOrderGridItem({ model: item });
      _this.$el.append(view.render().el);
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
  },
})

$(function(){
  if($(".reserve_list table tbody").length > 0)
    new Mis.Views.SubscribeOrderView()
})
