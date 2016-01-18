Sells = {

  initialize: function(store_id){
    this.display_year_sales_bar(store_id),
    this.display_payment_ways_pie(store_id),
    this.display_month_sales_pie(store_id),
    this.display_month_sales_line(store_id)
  },

  display_year_sales_bar: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/sales", function(params){
      year_sales_bar_chart(params.data);
    })
  },

  display_payment_ways_pie: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/sales/payments", function(params){
      payment_ways_pie_chart(params.data);
    })
  },

  display_month_sales_pie: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/sales/categories", function(params){
      month_sales_pie_chart(params.data);
    })
  },

  display_month_sales_line: function(store_id){
    $.get("/api/sas/stores/" + store_id + "/sales/days", function(params){
      month_sales_line_chart(params.data);
    })
  },
}
