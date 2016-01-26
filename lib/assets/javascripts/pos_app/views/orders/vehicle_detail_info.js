Mis.Views.VehicleDetailInfoView = Backbone.View.extend({
  el: ".vehicle_details_info",
  template: JST["pos/orders/vehicle_detail_info"],
  initialize: function(){
    this.render();
  },
  render: function(){
    this.$el.html(this.template());
  }
})
