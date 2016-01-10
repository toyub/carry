Mis.Views.SubscribeOrderForm = Backbone.View.extend({
  el: ".window_wrap",
  template: JST["pos/subscribe_order/form"],
  events: {
    "click .construction_status .save_btn": "commit",
    "change select[name='license_number']": "setStoreVehicleData",
    "click .choose_project": "handlerItemAbleWindow",
    "click .save_btn": "saveOrder"
  },
  initialize: function(){
    this.storeVehicle = new Mis.Models.StoreVehicle();
    //this.listenTo(this.storeVehicle, "change", this.render)
    this.render();

    this.subscribeOrderItemView = new Mis.Views.SubscribeOrderItemView();
  },
  render: function(){
    this.$el.html(this.template(this.storeVehicle.attributes));
    this.initDatetimePicker();
    this.initSelectInput();

    Mis.Helpers.numberBoxInput();
    return this.$el;
  },
  commit: function(evt){
    evt.preventDefault();
  },
  initDatetimePicker: function(){
    $(".datetimepicker").datetimepicker({
      lang: "zh",
      format: 'Y-m-d H:i',
    });
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

  setStoreVehicleData: function(e){
    var StoreVehicleId = e.target.value;
    var _this = this;
    this.storeVehicle.id = StoreVehicleId;

    this.storeVehicle.fetch({
      success: function(){
        $(".js-customer-name").val(_this.storeVehicle.attributes.store_customer.full_name);
        $(".js-mobile").val(_this.storeVehicle.attributes.store_customer.phone_number);
        $(".js-brand-name").val(_this.storeVehicle.attributes.vehicle_brand.name);
        $(".js-model").val(_this.storeVehicle.attributes.vehicle_model.name);
        $(".js-series").val(_this.storeVehicle.attributes.vehicle_series.name);

        Mis.Vues.VechileInfo.vehicleInfoData = _this.storeVehicle.attributes;
      }
    });
  },

  handlerItemAbleWindow: function(){
    $(".order_items").show();
  },

  saveOrder: function(e){
    var target = e.target;
    var storeOrderParams = {
      vehicle_id: $(".js-store-order-vehicle-id").text(),
      material_saleinfos: Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems,
      packages: Mis.Vues.PackageItem.packageItems,
      services: Mis.Vues.ServiceItem.serviceItems,
      remark: $(".remark").text(),
    };

    if(storeOrderParams.vehicle_id == ""){
      $.alert({text: "请选择车辆"});
    }else{
      $.ajax({
        method: "POST",
        url: '/api/store_subscribe_orders',
        data: storeOrderParams
      }).done(function(){
        $.alert({text: "订单保存成功！"});
      }).fail(function(e){
        $.alert({text: "订单保存失败！"});
      })
    }
  }
})
