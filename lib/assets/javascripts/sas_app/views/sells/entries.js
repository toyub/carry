Sells = {
  display_year_sales_bar: function(){
    $.get("/api/store_sales/", function(data){
      year_sales_bar_chart(data);
    })
  },

  display_payment_ways_pie: function(){
    $.get("/api/store_sales", function(data){
      payment_ways_pie_chart(data);
    })
  },

  display_month_sales_pie: function(){
    $.get("/api/store_sales", function(data){
      month_sales_pie_chart(data);
    })
  },

  display_month_sales_line: function(){
    $.get("/api/store_sales", function(data){
      month_sales_line_chart(data);
    })
  }

}
