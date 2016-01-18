Customer = {

  initialize: function(store_id){
    this.display_customer_gender_bar(store_id),
    this.display_customer_category_pie(store_id),
    this.display_vehicle_price_consuming_bar(store_id),
    this.display_vehicle_consuming_rank_bar(store_id),
    this.display_consuming_distribution_pie(store_id),
    this.display_consuming_week_bar(store_id),
    this.display_top_editors()
  },

  display_customer_gender_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/customer_gender", function(params){
      customer_gender(params.data);
    })
  },

  display_customer_category_pie: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/customers", function(params){
      category_consuming_pie(params.data);
    })
  },

  display_vehicle_price_consuming_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/vehicles", function(params){
      vehicle_price_consuming_bar(params.data);
    })
  },

  display_vehicle_consuming_rank_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/vehicle_brand", function(params){
      vehicle_consuming_rank_bar(params.data);
    })
  },

  display_consuming_distribution_pie: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/customer_consuming", function(params){
      consuming_distribution_pie(params.data);
    })
  },

  display_consuming_week_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/consuming_week", function(params){
      consuming_week_bar(params.data);
    })
  },

  display_top_editors: function(){
    top_editors();
  },

}
