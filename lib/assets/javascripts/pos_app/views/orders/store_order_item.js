Mis.Views.StoreOrderItemView = Backbone.View.extend({
  el: ".store-order-item-block",
  template: JST["pos/orders/store_order_item"],
  events: {
    "click .js-material-saleinfo-checkbox": "setMaterialSaleInfoData"
  },
  initialize: function(){
    this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos;
    this.materialSaleinfoAry = []
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
    Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems = this.materialSaleinfoAry.slice();
  },
  initMaterialSaleinfoCheckBoxClickEvent: function(){
    var _this = this;

    $(".material-saleinfo-checkbox").click(function(e){
      var checkbox = e.target;
      var id = $(checkbox).data("material-saleinfo-id");

      if(checkbox.checked){
        var materialSaleinfoObj = _this.materialCollection.where({id: id});
        _this.materialSaleinfoAry.push(materialSaleinfoObj[0].attributes);
      }else{
        var materialSaleinfoObj = _this.materialCollection.where({id: id});
        _this.materialSaleinfoAry.pop(materialSaleinfoObj[0].attributes);
      }
    })
  },
})
