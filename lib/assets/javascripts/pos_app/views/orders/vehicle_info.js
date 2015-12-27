Mis.Views.VehicleInfoView = Backbone.View.extend({
  el: ".vehicle_info",
  template: JST["pos/orders/vehicle_info"],
  initialize: function(){
    this.render();
  },
  render: function(){
    this.$el.html(this.template());
  },
  setInfoData: function(atrributes){
    this.$el.html(this.template(atrributes));
  }
})
