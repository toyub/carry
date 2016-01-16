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
    $.get("/api/sas/stores/" + store_id + "/customer_gender", function(data){
      customer_gender(data);
    })
  },

  display_customer_category_pie: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/customers", function(data){
      category_consuming_pie(data);
    })
  },

  display_vehicle_price_consuming_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/vehicles", function(data){
      vehicle_price_consuming_bar(data);
    })
  },

  display_vehicle_consuming_rank_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/vehicle_brand", function(data){
      vehicle_consuming_rank_bar(data);
    })
  },

  display_consuming_distribution_pie: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/customer_consuming", function(data){
      consuming_distribution_pie(data);
    })
  },

  display_consuming_week_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/consuming_week", function(data){
      consuming_week_bar(data);
    })
  },

  display_top_editors: function(){
    top_editors();
  },

}
