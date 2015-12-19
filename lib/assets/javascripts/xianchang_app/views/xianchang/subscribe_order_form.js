Mis.Views.SubscribeOrderForm = Backbone.View.extend({
  el: ".window_wrap",
  template: JST["xianchang/subscribe_order/form"],
  events: {
    "click .construction_status .save_btn": "commit",
    "change select[name='license_number']": "setStoreVehicleData",
  },
  initialize: function(){
    this.render();
    this.initSelectInput();
  },
  render: function(){
    this.$el.html(this.template());
    this.initDatetimePicker();

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
  }
})
