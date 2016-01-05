Mis.Views.PosRecommendedOrderIndexView = Backbone.View.extend({
  initialize: function(){
    console.log("haha");
    this.initSelectInput();
  },
  initSelectInput: function(){
    console.log("mouseshi is here");

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
})

$(function(){
  if($(".pos-recommended-orders-index").length > 0){
    new Mis.Views.PosRecommendedOrderIndexView();
  }
})
