Mis.Views.SubscribeOrderGridView = Backbone.View.extend({
  el: ".reserve_list table tbody",
  render: function(){
    var _this = this;
    this.$el.html("");

    this.collection.each(function(item){
      var view = new Mis.Views.SubscribeOrderGridItem({ model: item });
      _this.$el.append(view.render().el);
    });
    return this.$el;
  },

  initialize: function(){
    this.collection = new Mis.Collections.StoreSubscribeOrders;
    this.listenTo(this.collection, 'add', _.bind(this.render, this));
    this.listenTo(this.collection, 'remove', _.bind(this.render, this));
    this.collection.fetch()
  },
})
