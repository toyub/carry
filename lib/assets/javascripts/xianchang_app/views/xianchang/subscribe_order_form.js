Mis.Views.SubscribeOrderForm = Backbone.View.extend({
  el: ".window_wrap",
  template: JST["xianchang/subscribe_order/form"],
  events: {
    "click .construction_status .save_btn": "commit",
    "change select[name='license_number']": "setStoreVehicleData",
  },
  initialize: function(){
    this.storeVehicle = new Mis.Models.StoreVehicle();
    //this.listenTo(this.storeVehicle, "change", this.render)

    this.render();
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
        $(".js-brand-name").val(_this.storeVehicle.attributes.brand.name);
        $(".js-model").val(_this.storeVehicle.attributes.model);
        $(".js-series").val(_this.storeVehicle.attributes.series);
      }
    });
  }
})
