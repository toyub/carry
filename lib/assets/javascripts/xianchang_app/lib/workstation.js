$(document).on("click", ".js-close", function(){
    $(this).parents(".js-dialog").remove();
})
$(document).on("click", ".js-vehicle", function(){
    var orderId = $(this).data("order").id;
    $.get("/xianchang/store_orders/" + orderId, function(){})
})
$(document).on("click", ".js-edit-construction-form", function(){
    $(".js-construction-form").show();
})
$(document).on("click", ".js-close-construction-form", function(){
    $(".js-construction-form").hide();
})
$(document).on("click", ".js-show-mechanics", function(){
    var workflow = $(this).data("id");
    if($(this).hasClass("fa-plus")){
      $.get("/xianchang/store_workflows/" + workflow + "/free_mechanics");
      $("#workflow-" + workflow).show();
      $(this).addClass("fa-minus").removeClass("fa-plus");
    }else{
      $("#workflow-" + workflow).hide();
      $(this).addClass("fa-plus").removeClass("fa-minus");
    }
    //$("#workflow-" + workflow).toggle();
})
$(document).on("click", ".js-mechanics li", function(){
    var workflowId = $(this).parent().data("id");
    var mechanic = "workflow-" + workflowId + "-mechanics-" + $(this).data("id");
    var item = "<li class='do_coise_close js-mechanic' id='";
    item += mechanic;
    item += "'><span>";
    item += $(this).data("name");
    item += "<i class='coise_close lnr-cross lnr js-mechanic-close'></i></span>";
    item += "<input type='hidden' name='workflow[";
    item += workflowId;
    item += "][mechanics]["
    item += $(this).data("id");
    item += "][id]' value='";
    item += $(this).data("id");
    item += "'/>";
    item += "<input type='hidden' name='workflow[";
    item += workflowId;
    item += "][mechanics][";
    item += $(this).data("id");
    item += "][name]' value='";
    item += $(this).data("name");
    item += "'/></li>";
    console.log(item);
    if($("#" + mechanic).length == 0) {
      $("#workflow-" + workflowId + "-mechanics").append(item);
    }
})
$(document).on("click", ".js-mechanic-close", function(){
    $(this).closest(".js-mechanic").remove();
})

$(document).on("dragstart", "li.js-draggable", function(e){
    var data = JSON.stringify($(e.target.parentNode).data("order"));
    e.originalEvent.dataTransfer.setData("application/json", data);
    console.log($(e.target.parentNode).data("order"));
})
$(document).on("dragover", "li.js-station", function(e){
    if (e.preventDefault) e.preventDefault();
    return false;
})
$(document).on("drop", "li.js-station", function(e){
    if (e.stopPropagation) e.stopPropagation();
    var data = e.originalEvent.dataTransfer.getData("application/json");
    if(data){
      var order = JSON.parse(data);
      var tip = order.state == 'queuing' ? '确认开始此流程？' : '是否确定结束该流程？';
      console.log(order);
      var canDispatch = true;
      if(order.state == 'queuing'){
        $.ajax({
          url: "/xianchang/store_orders/" + order.id + "/check_dispatch",
          method: "GET",
          async: false
        }).done(function(data){
          canDispatch = data.status;
        })
      }
      if(canDispatch){
        var target = $(e.target).closest("li.js-station");
        if($(target).find(".idle_station").length > 0){
          $.confirm({
            text: tip,
            confirm: function(){
              $.ajax({
                url: "/xianchang/store_workstations/" + $(target).data("id") + "/perform",
                method: "PUT",
                data: {order_id: order.id}
              })
            }
          })
        }
      }else{
        ZhanchuangAlert("已经有正在施工的订单!");
      }
    }
    return false;
})

$(document).on("dragover", "div.js-finished-orders", function(e){
    if (e.preventDefault) e.preventDefault();
    return false;
})

$(document).on("drop", "div.js-finished-orders", function(e){
    if (e.stopPropagation) e.stopPropagation();
    var data = e.originalEvent.dataTransfer.getData("application/json");
    if(data){
      var order = JSON.parse(data);
      var tip = "结束订单后，将不能返回，确认？";
      var target = $(e.target);
      if($(target).find(".js-finished").length > 0){
        $.confirm({
          text: tip,
          confirm: function(){
            $.ajax({
              url: "/xianchang/store_orders/" + order.id + "/terminate",
              method: "PUT",
              data: {from: order.state}
            })
          }
        })
      }
    }
    return false;
})
