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

});
