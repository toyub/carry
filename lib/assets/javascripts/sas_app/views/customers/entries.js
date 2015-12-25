Customer = {
  display_customer_gender_bar: function(){
    $.get("/api/store_customer_gender", function(data){
      customer_gender(data);
    })
  },

  display_customer_category_pie: function(){
    $.get("/api/statistic/customers/category_proportion", function(data){
      category_consuming_pie(data);
    })
  },

  display_vehicle_price_consuming_bar: function(){
    $.get("/api/statistic/customers/vehicle_price_consuming_proportion", function(data){
      vehicle_price_consuming_bar(data);
    })
  },

  display_vehicle_consuming_rank_bar: function(){
    $.get("/api/statistic/customers/vehicle_consuming_rank", function(data){
      vehicle_consuming_rank_bar(data);
    })
  },

  display_consuming_distribution_pie: function(){
    $.get("/api/statistic/customers/consuming_distribution", function(data){
      consuming_distribution_pie(data);
    })
  },

  display_consuming_week_bar: function(){
    $.get("/api/statistic/customers/consuming_week", function(data){
      consuming_week_bar(data);
    })
  },

}
