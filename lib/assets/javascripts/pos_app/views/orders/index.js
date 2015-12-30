Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "showCustomerInfoView",
    "click .query_btn": "handlerQueryOrder",
    "change select[name='license-number']": "setVehicleInfoData",
    "click .js-save-for-pending-btn": "saveOrder",
    "click .js-save-for-queuing-btn": "saveOrder"
  },
  initialize: function(){

    // view
    this.customerInfoView = new Mis.Views.CustomerInfoView();
    this.storeOrderItemView = new Mis.Views.StoreOrderItemView();

    // model
    this.storeVehicle = new Mis.Models.StoreVehicle();

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
        window.mouse = _this.storeVehicle.attributes;
        Mis.Vues.VechileInfo.vehicleInfoData = _this.storeVehicle.attributes;
      }
    });
  },
  saveOrder: function(e){
    var target = e.tareger;
    var storeOrderParams = {
      vehicle_id: $(".js-store-order-vehicle-id").text(),
      state: $(target).data("state"),
      situation: {
        oil_range: $("#oil_range").val(),
        km: $(".js-store-order-km").val(),
        damage_1: $(".js-store-order-damage-1").val(),
        damage_2: $(".js-store-order-damage-2").val(),
        damage_3: $(".js-store-order-damage-3").val(),
        damage_4: $(".js-store-order-damage-4").val(),
        damage_5: $(".js-store-order-damage-5").val(),
        damage_6: $(".js-store-order-damage-6").val(),
        damage_7: $(".js-store-order-damage-7").val(),
        damage_8: $(".js-store-order-damage-8").val(),
        damage_9: $(".js-store-order-damage-9").val(),
        damage_10: $(".js-store-order-damage-10").val(),
        damage_11: $(".js-store-order-damage-11").val(),
        damage_13: $(".js-store-order-damage-13").val(),
        damage_14: $(".js-store-order-damage-14").val(),
        damage_15: $(".js-store-order-damage-15").val(),
        damage_16: $(".js-store-order-damage-16").val(),
        damage_17: $(".js-store-order-damage-17").val(),
        damage_18: $(".js-store-order-damage-18").val(),
        damage_19: $(".js-store-order-damage-19").val(),
        damage_20: $(".js-store-order-damage-20").val(),
        damage_21: $(".js-store-order-damage-21").val()
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
