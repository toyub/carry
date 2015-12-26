Mis.Models.StoreVehicle = Backbone.Model.extend({
  url: function() { return '/api/store_vehicles/' + encodeURIComponent(this.id) }
})
