Mis.Views.MaterialItemable = Backbone.View.extend({
  el: ".order_commodity",
  template: JST["pos/subscribe_order/material_itemable"],
  initialize: function(){
    this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos;
    var _this = this;

    this.materialCollection.fetch({success: _this.render() })
  },
  render: function(){
    this.$el.html(this.template({materials:  this.materialCollection}));
  }
})
