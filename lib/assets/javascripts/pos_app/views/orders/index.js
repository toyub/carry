Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "showCustomerInfoView",
    "click .query_btn": "handlerQueryOrder",
    "change select[name='license-number']": "setVehicleInfoData",
    "click .js-save-for-pending-btn": "saveOrder",
    "click .js-save-for-queuing-btn": "saveOrder",
    'click .js-edit-customer': 'editCustomer',
    'click .js-edit-vehicle': 'editVehicle'
  },
  initialize: function(){

    // view
    this.storeOrderItemView = new Mis.Views.StoreOrderItemView();

    // model
    this.storeVehicle = new Mis.Models.StoreVehicle();

    this.initSelectInput()
    this.vehicle_situation = new Vue(Mis.Vues.VehicleSituation);
  },
  showCustomerInfoView: function(el){
    var target = $(el.currentTarget);
    if (target.data("target") == "order_items"){
      this.hideOtherRightInfomationDiv();
      this.storeOrderItemView.show();
    }
  },
  hideOtherRightInfomationDiv: function(){
    this.storeOrderItemView.hide();
  },
  editCustomer: function(){
    Mis.Views.editCustomer(this.storeVehicle.attributes);
  },
  editVehicle: function(){
    if(Mis.Vues.VechileInfo.vehicleInfoData.id){
      Mis.Views.editVehicle(this.storeVehicle.attributes);
    }else{
      $.alert({text: "先选择车辆"});
    }
  },
  handlerQueryOrder: function(){
    console.log("click the query order btn");
  },
  initSelectInput: function(){
    $(".js-store-vehicle-license-number-input").select2({
      language: "zh-CN",
      ajax: {
        url: "/api/store_vehicles/search",
        dataType: "json",
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
        Mis.Vues.VechileInfo.vehicleInfoData = _this.storeVehicle.attributes;
      }
    });
  },
  saveOrder: function(e){
    var target = e.target;
    var storeOrderParams = {
      vehicle_id: $(".js-store-order-vehicle-id").text(),
      state: $(target).data("state"),
      situation: {
        fuel_gauge: $("#oil_range").val(),
        mileage: $(".js-store-order-km").val(),
        damages:[]
      },
      material_saleinfos: Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems,
      packages: Mis.Vues.PackageItem.packageItems,
      services: Mis.Vues.ServiceItem.serviceItems,
    };

    if(storeOrderParams.vehicle_id == ""){
      $.alert({text: "请选择车辆"});
    }else{
      $.ajax({
        method: "POST",
        url: '/api/store_orders',
        data: storeOrderParams
      }).done(function(){
        $.alert({text: "订单保存成功！"});
      }).fail(function(e){
        $.alert({text: "订单保存失败！"});
      })
    }
  },
})

$(function(){
  if($(".pos-orders-index").length > 0){
    new Mis.Views.PosOrderIndexView();
  }
})
