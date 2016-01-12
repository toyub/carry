Customer = {
  display_customer_gender_bar: function(){
    $.get("/api/sas/stores/1/customer_gender", function(data){
      customer_gender(data);
    })
  },

  display_customer_category_pie: function(){
    $.get("/api/sas/stores/1/customers", function(data){
      category_consuming_pie(data);
    })
  },

  display_vehicle_price_consuming_bar: function(){
    $.get("/api/sas/stores/1/vehicles", function(data){
      vehicle_price_consuming_bar(data);
    })
  },

  display_vehicle_consuming_rank_bar: function(){
    $.get("/api/sas/stores/1/vehicle_brand", function(data){
      vehicle_consuming_rank_bar(data);
    })
  },

  display_consuming_distribution_pie: function(){
    $.get("/api/sas/stores/1/customer_consuming", function(data){
      consuming_distribution_pie(data);
    })
  },

  display_consuming_week_bar: function(){
    $.get("/api/sas/stores/1/sales", function(data){
      consuming_week_bar(data);
    })
  },

  display_top_editors: function(){
    top_editors();
  },

}
