Mis.Views.PosRecommendedOrderIndexView = Backbone.View.extend({
  el: ".pos-recommended-orders-index",
  events: {
    "change select[name='recommended-order-license-number']": "setVehicleInfoData",
    "click .js-save-btn": "saveOrder",
  },
  initialize: function(){
    this.storeVehicle = new Mis.Models.StoreVehicle();
    this.storeOrderItemView = new Mis.Views.StoreOrderItemView();

    this.initSelectInput();
  },
  initVueObj: function(){
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
    var recommenedOrderParams = {
      vehicle_id: $(".js-store-order-vehicle-id").text(),
      material_saleinfos: Mis.Vues.MaterialItem.MaterialItems,
      packages: Mis.Vues.PackageItem.packageItems,
      services: Mis.Vues.ServiceItem.serviceItems,
      recommended_reason: $(".js-recommended-reason").val(),
      refuse_reason: $(".js-refuse-reason").val(),
      recommended_date: $(".js-recommended-date").val(),
      recommended_date: $(".js-recommended-order-remark").val(),
    };

    if(recommenedOrderParams.vehicle_id == ""){
      $.alert({text: "请选择车辆"});
    }else{
      $.ajax({
        method: "POST",
        url: '/api/recommended_orders',
        data: recommenedOrderParams,
      }).done(function(){
        $.alert({text: "保存成功！"});
      }).fail(function(e){
        $.alert({text: "保存失败！"});
      })
    }
  }
})

$(function(){
  if($(".pos-recommended-orders-index").length > 0){
    new Mis.Views.PosRecommendedOrderIndexView();
  }
})
