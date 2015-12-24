Sells = {
  show_year_consume: function(){
    $.get("/api/statistic/sells/annual_sales/", function(data){
      year_consume_chart(data);
    })
  }
}
