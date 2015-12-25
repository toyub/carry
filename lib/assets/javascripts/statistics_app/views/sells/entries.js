Sells = {
  display_year_sales_bar: function(){
    $.get("/api/statistic/sells/annual_sales/", function(data){
      year_sales_bar_chart(data);
    })
  },

  display_payment_ways_pie: function(){
    $.get("/api/statistic/sells/payment_ways/", function(data){
      payment_ways_pie_chart(data);
    })
  },

  display_month_sales_pie: function(){
    $.get("/api/statistic/sells/month_sales_pie", function(data){
      month_sales_pie_chart(data);
    })
  },

  display_month_sales_line: function(){
    $.get("/api/statistic/sells/month_sales_line", function(data){
      month_sales_line_chart(data);
    })
  }

}
