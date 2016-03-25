jQuery(function($){
  $(document).on('click', 'i.fa.fa-chevron-down.cursor-pointer.js-slide-down', function() {
    $("div#js-order-"+$(this).data("id")).removeClass("slide_up").addClass("slide_down");
  });

  $(document).on('click', 'i.fa.fa-chevron-up.cursor-pointer.js-slide-up', function() {
    $("div#js-order-"+$(this).data("id")).removeClass("slide_down").addClass("slide_up");
  });

  $("input#submit").on("click",function(){
      if($("input:checked").length == 0){
        alert("请选择对应的订单!");
        return false;
      };
  });

  $("a.font-14.fa.fa-arrow-down.show_more").on("click", function(){
    var next_page = parseInt($('#js-current-page').val()) + 1;
    var action = $('#action').val();
    var url = "";
    if(action)
      url = "/crm/store_customers/"+$(this).data("customer")+"/store_repayments/"+ action;
    else
      url = "/crm/store_customers/"+$(this).data("customer")+"/store_repayments";
    $.ajax({
      type: "get",
      url: url,
      data: { page: next_page },
      dataType: "script",
      success: function () {}
    });
  });

});
