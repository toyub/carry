jQuery(function($){
  $("i.fa.fa-chevron-down.cursor-pointer.js-slide-down").on("click",function(){
    $("div#js-order-"+$(this).data("id")).removeClass("slide_up").addClass("slide_down");
  });

  $("i.fa.fa-chevron-up.cursor-pointer.js-slide-up").on("click",function(){
    $("div#js-order-"+$(this).data("id")).removeClass("slide_down").addClass("slide_up");
  });

  $("input#submit").on("click",function(){
      if($("input:checked").length == 0){
        alert("请选择对应的订单!");
        return false;
      };
  });

  $("a.font-14.fa.fa-arrow-down.show_more").on("click", function(){
    $.ajax({
      type: "get",
      url: "/crm/store_customers/"+$(this).data("customer")+"/store_repayments/"+ $("input#action").val() +"",
      data: { count: $("input#count").val() },
      dataType: "script",
      success: function () {}
    });
  });

});
