Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "showCustomerInfoView",
    "click .query_btn": "handlerQueryOrder",
    "change select[name='license-number']": "setVehicleInfoData",
  },
  initialize: function(){

    // view
    this.customerInfoView = new Mis.Views.CustomerInfoView();
    this.storeOrderItemView = new Mis.Views.StoreOrderItemView();
    //this.storeVehicleInfoView = new Mis.Views.VehicleInfoView();

    // 使用 Vue 替换使用
    //this.materialSaleinfoTableItem = new Mis.Views.MaterialSaleinfoTableItemView();

    // model
    this.storeVehicle = new Mis.Models.StoreVehicle();

    // collection
    // this.collection

    this.initSelectInput()
  },
  showCustomerInfoView: function(el){
    var target = $($(el.currentTarget));
    this.hideOtherRightInfomationDiv();
    if(target.data("target") == "completing_customer"){
      this.customerInfoView.show();
    }else if (target.data("target") == "order_items"){
      this.storeOrderItemView.show();
    }
  },
  hideOtherRightInfomationDiv: function(){
    this.storeOrderItemView.hide();
    this.customerInfoView.hide();
  },
  handlerQueryOrder: function(){
    console.log("click the query order btn");
  },
  initSelectInput: function(){
    $(".js-store-vehicle-license-number-input").select2({
      ajax: {
        url: "/api/store_vehicles/search",
        dataType: "json",
        minimumInputLength: 3,
        data: function(params){
          return {
            q: params.term
          }
        },
        processResults: function(data, params){
          params.page = params.page || 1;

          return {
            results: data.items,
            pagination: {
              more: (params.page * 30) < data.total_count
            }
          };
        },
      }
    });
  },
  setVehicleInfoData: function(e){
    var StoreVehicleId = e.target.value;
    var _this = this;
    this.storeVehicle.id = StoreVehicleId;

    this.storeVehicle.fetch({
      success: function(){
        window.mouse = _this.storeVehicle.attributes;
        Mis.Vues.VechileInfo.vehicleInfoData = _this.storeVehicle.attributes;
        //_this.storeVehicleInfoView.setInfoData(_this.storeVehicle.attributes);
      }
    });
  }
})

$(function(){
  if($(".pos-orders-index").length > 0){
    new Mis.Views.PosOrderIndexView();
  }
})
