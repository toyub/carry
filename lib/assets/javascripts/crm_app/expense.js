jQuery(function($){
  $("a#tousu").on('click', function(){
    var order = $(this).data("order");
    $("div.window_wrap").show();
    $('#complaint_form').attr('action', "/api/store_orders/"+ order +"/complaints");
    $("input[name='complaint[store_order_id]']").val(order);
    $.get("/api/store_orders/"+ order +"/complaints/new", function(data){
      $("input[name='complaint[store_vehicle_id]']").val(data.store_vehicle_id);
      $("dd.dd-vehicle").text(data.license_number);
      $("dd.dd-order-numero").text(data.numero);
      $("ul#creator").append("<li><label>"+ data.creator.full_name +"<input name='complaint[detail][principal][saler]' type='checkbox' value="+ data.creator.id +" ></label></li>");
      data.mechanics.forEach(function(item){
        $("ul#mechanic").append("<li><label>"+ item.name +"<input name='complaint[detail][principal][mechanics][]' type='checkbox' value=" + item.id + "></label></li>");
      });
    });
  });

  $("a#tousu_cancel").on("click", function(){
    $("div.window_wrap").hide();
    $("ul#creator").html("");
    $("ul#mechanic").html("");
  });
});
