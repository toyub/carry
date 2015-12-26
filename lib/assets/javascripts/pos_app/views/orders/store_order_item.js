Mis.Views.StoreOrderItemView = Backbone.View.extend({
  el: ".store-order-item-block",
  template: JST["pos/orders/store_order_item"],
  events: {
    "click .js-material-saleinfo-checkbox": "setMaterialSaleInfoData"
  },
  initialize: function(){
    this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos;
    this.materialSaleinfoIds = []
    var _this = this;

    this.listenTo(this.materialCollection, 'add', this.render);

    this.materialCollection.fetch()
  },
  render: function(){
    var materials = []
    this.materialCollection.each(function(item){
      materials.push(item.attributes);
    })
    this.$el.html(this.template({materials:  materials}));
    this.initMaterialSaleinfoCheckBoxClickEvent();
  },
  show: function(){
    this.$el.show();
  },
  hide: function(){
    this.$el.hide();
  },
  setMaterialSaleInfoData: function(){
  },
  initMaterialSaleinfoCheckBoxClickEvent: function(){
    var _this = this;
    $(".material-saleinfo-checkbox").click(function(e){
      var checkbox = e.target;
      var id = $(checkbox).data("material-saleinfo-id");

      if(checkbox.checked){
        _this.materialSaleinfoIds.push(id);
      }else{
        _this.materialSaleinfoIds.pop(id);
      }
    })
  },
})
