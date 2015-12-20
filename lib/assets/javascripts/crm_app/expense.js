jQuery(function($){
  $("a#tousu").on('click', function(){
    var customer = $(this).data("customer");
    var order = $(this).data("order");
    $("div.window_wrap").show();
    $('#complaint_form').attr('action', "/api/store_orders/"+ order +"/complaints");
    $("input[name='complaint[store_order_id]']").val(order);
    $.get("/api/store_orders/"+ order +"/complaints/new", function(data){
      $("input[name='complaint[store_vehicle_id]']").val(data.store_vehicle_id);
      $("dd.dd-vehicle").text(data.current_vehicle);
      $("dd.dd-order-numero").text(data.numero);
      $("ul#creator").append("<li><label>"+ data.creators[0].name +"<input name='complaint[detail][principal][saler]' type='checkbox' value="+ data.creators[0].id +" ></label></li>");
      data.mechanic.forEach(function(item){
        $("ul#mechanic").append("<li><label>"+ item.name +"<input name='complaint[detail][principal][mechanic][]' type='checkbox' value=" + item.id + "></label></li>");
      });
    });
  });

  $("a#tousu_cancel").on("click", function(){
    $("div.window_wrap").hide();
    $("ul#creator").html("");
    $("ul#mechanic").html("");
  });
});
