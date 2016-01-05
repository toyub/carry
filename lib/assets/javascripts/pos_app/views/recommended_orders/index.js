Mis.Views.PosRecommendedOrderIndexView = Backbone.View.extend({
  events: {
    "change select[name='license-number']": "setVehicleInfoData",
  },
  initialize: function(){
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
})

$(function(){
  if($(".pos-recommended-orders-index").length > 0){
    console.log("mouse is ehreh")
    new Mis.Views.PosRecommendedOrderIndexView();
  }
})
