Mis.Views.MaterialSaleinfoTableItemView = Backbone.View.extend({
  el: ".material-saleinfo-table-items",
  template: JST["pos/orders/material_saleinfo_table_item"],
  initialize: function(){
    this.materialSaleinfo = new Mis.Models.MaterialItemable();
    this.render();
  },
  render: function(){
    this.$el.html(this.template(this.materialSaleinfo.attributes));
  }
})
