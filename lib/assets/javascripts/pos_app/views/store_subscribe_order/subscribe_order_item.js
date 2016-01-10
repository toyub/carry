Mis.Views.SubscribeOrderItemView = Backbone.View.extend({
  el: ".store-subscribe-order-items",
  template: JST["pos/subscribe_order/itemable_left"],
  events: {
    "click .js-material-saleinfo-checkbox": "setMaterialSaleInfoData",
    "click .js-package-checkbox": "setPackageData",
    "click .js-service-checkbox": "setServiceData",
    "click .order_items_category li": "showItem"
  },
  initialize: function(){
    this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos;
    //this.packageCollection = new Mis.Collections.StorePackages;
    //this.serviceCollection = new Mis.Collections.StoreServices;

    this.materialSaleinfoAry = []
    this.packageAry = []
    this.serviceAry = []

    var _this = this;

    this.listenTo(this.materialCollection, 'add', this.render);
    //this.listenTo(this.packageCollection, 'add', this.render);
    //this.listenTo(this.serviceCollection, 'add', this.render);

    this.materialCollection.fetch()
    //this.packageCollection.fetch()
    //this.serviceCollection.fetch()
  },
  render: function(){
    var materials = []
    var packages = []
    var services = []

    this.materialCollection.each(function(item){
      materials.push(item.attributes);
    })

    //this.packageCollection.each(function(item){
      //packages.push(item.attributes);
    //})

    //this.serviceCollection.each(function(item){
      //services.push(item.attributes);
    //})

    this.$el.html(this.template({materials:  materials, packages: packages, services: services}));

    this.initMaterialSaleinfoCheckBoxClickEvent();
    //this.initPackageCheckBoxClickEvent();
    //this.initServiceCheckBoxClickEvent();

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
  setPackageData: function(){
    Mis.Vues.PackageItem.packageItems = this.packageAry.slice();
  },
  setServiceData: function(){
    Mis.Vues.ServiceItem.serviceItems = this.serviceAry.slice();
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
  initPackageCheckBoxClickEvent: function(){
    var _this = this;

    $(".package-checkbox").click(function(e){
      var checkbox = e.target;
      var id = $(checkbox).data("package-id");

      if(checkbox.checked){
        var packageObj = _this.packageCollection.where({id: id});
        _this.packageAry.push(packageObj[0].attributes);
      }else{
        var packageObj = _this.packageCollection.where({id: id});
        _this.packageAry.pop(packageObj[0].attributes);
      }
    })
  },
  initServiceCheckBoxClickEvent: function(){
    var _this = this;

    $(".service-checkbox").click(function(e){
      var checkbox = e.target;
      var id = $(checkbox).data("service-id");

      if(checkbox.checked){
        var serviceObj = _this.serviceCollection.where({id: id});
        _this.serviceAry.push(serviceObj[0].attributes);
      }else{
        var serviceObj = _this.serviceCollection.where({id: id});
        _this.serviceAry.pop(serviceObj[0].attributes);
      }
    })
  },
  showItem: function(e){
    this.hideOtherTableItem();

    $("." + $(e.target).data('table-class')).show();
    $(e.target).addClass("bg-color-8E81B8");
    $(e.target).addClass("color-fff");
  },
  hideOtherTableItem: function(){
    $(".js-material-items-table").hide();
    $(".js-package-items-table").hide();
    $(".js-service-items-table").hide();
    $(".order_items_category li").removeClass("bg-color-8E81B8 color-fff");
  }
})
