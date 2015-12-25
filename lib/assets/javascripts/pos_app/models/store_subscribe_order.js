Mis.Models.StoreSubscribeOrder = Backbone.Model.extend({
  url: function() { return '/api/store_subscribe_orders/' + encodeURIComponent(this.id) }
})
