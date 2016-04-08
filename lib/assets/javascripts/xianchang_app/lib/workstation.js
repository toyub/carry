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
$(document).on("click", ".js-show-mechanics", function(){
    var workflow = $(this).data("id");
    if($(this).hasClass("fa-plus")){
      $("#workflow-" + workflow).show();
      $(this).addClass("fa-minus").removeClass("fa-plus");
    }else{
      $("#workflow-" + workflow).hide();
      $(this).addClass("fa-plus").removeClass("fa-minus");
    }
})
$(document).on("change", "select.js-select-workstations", function(){
  var workflow = $(this).data("id");
  if($(this).val().length > 0){
    $.get("/xianchang/store_workflows/" + workflow + "/free_mechanics", {workstation: $(this).val()});
  }
})
$(document).on("click", ".js-mechanics li", function(){
    var workflowId = $(this).parent().data("id");
    var mechanic = "workflow-" + workflowId + "-mechanics-" + $(this).data("id");
    var item = JST['xianchang/construction/mechanic']({workflow: {id: workflowId}, m: {id: $(this).data("id"), full_name: $(this).data("name")}});
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
})
$(document).on("dragover", "li.js-station", function(e){
    if (e.preventDefault) e.preventDefault();
    return false;
})
$(document).on("drop", "li.js-station", function(e){
    if (e.stopPropagation) e.stopPropagation();
    var data = e.originalEvent.dataTransfer.getData("application/json");
    var order = JSON.parse(data);
    var target = $(e.target).closest("li.js-station");
    if(!data || !$(target).find(".idle_station").length) return;
    var exchangeAction = function() {
      $.ajax({
        url: "/xianchang/store_workstations/" + $(target).data("id") + "/exchange",
        method: "PUT",
        data: {order_id: order.id, previous_workstation: order.previous_workstation}
      })
    };
    var terminateAction = function() {
      $.ajax({
        url: "/xianchang/store_workstations/" + $(target).data("id") + "/perform",
        method: "PUT",
        data: {order_id: order.id, previous_workstation: order.previous_workstation}
      })
    };
    var startAction = function(){
      $.ajax({
        url: "/xianchang/store_workstations/" + $(target).data("id") + "/start",
        method: "PUT",
        data: {order_id: order.id}
      })
    };
    if(order.state == 'queuing'){
      $.confirm({
        text: '确认开始此流程？',
        confirm: startAction
      })
    }else{
      $.multiConfirm({
        text: '是否确定结束该流程？',
        exchange: exchangeAction,
        terminate: terminateAction
      });
    }
})

$(document).on("dragover", "div.js-finished-orders", function(e){
    if (e.preventDefault) e.preventDefault();
    return false;
})

$(document).on("drop", "div.js-finished-orders", function(e){
    if (e.stopPropagation) e.stopPropagation();
    var data = e.originalEvent.dataTransfer.getData("application/json");
    if(!data) return;
    var order = JSON.parse(data);
    $.confirm({
      text: "结束订单后，将不能返回，确认？",
      confirm: function(){
        $.ajax({
          url: "/xianchang/store_orders/" + order.id + "/terminate",
          method: "PUT",
          data: {from: order.state}
        })
      }
    });
})

$(document).on("click", '.js-save', function(e){
  if (e.preventDefault) e.preventDefault();
  $.ajax({
    url: "/xianchang/store_orders/" + $(e.target).closest("form").data("order-id"),
    method: "PUT",
    data: $(e.target).closest("form").serializeJSON()
  })
})

$(document).on("click", '.js-execute', function(e){
  if (e.preventDefault) e.preventDefault();
  $.ajax({
    url: "/xianchang/store_orders/" + $(e.target).closest("form").data("order-id") + "/execute",
    method: "PUT",
    data: $(e.target).closest("form").serializeJSON()
  })
})

$(document).on("click", '.js-pause', (e) => {
  'use strict';
  if (e.preventDefault) e.preventDefault();
  let orderState = $(e.target).closest("form").data("order-state");
  let waitingInWorkstationAction = () => {
    $.ajax({
      url: "/xianchang/store_orders/" + $(e.target).closest("form").data("order-id") + "/pause_in_workstation",
      method: "PUT",
      data: $(e.target).closest("form").serializeJSON()
    })
  }
  let waitingInQueuingAreaAction = () => {
    $.ajax({
      url: "/xianchang/store_orders/" + $(e.target).closest("form").data("order-id") + "/pause_in_queuing_area",
      method: "PUT",
      data: $(e.target).closest("form").serializeJSON()
    })
  }
  let confirm = waitingInQueuingAreaAction;
  if(orderState == 'task_queuing'){
    $.confirm({
      text: '暂停后将不参与自动排单，请确认？',
      confirm,
    })
  }else{
    $.multiConfirm({
      text: '请选择操作？',
      exchange: waitingInWorkstationAction,
      terminate: waitingInQueuingAreaAction,
      exchangeButton: '在工位等待',
      termianteButton: '去等待区'
    });
  }
})

$(document).on('click', '.js-play', (e) => {
  'use strict';
  if (e.preventDefault) e.preventDefault();
  let orderState = $(e.target).closest("form").data("order-state");
  $.ajax({
    url: "/xianchang/store_orders/" + $(e.target).closest("form").data("order-id") + "/play",
    method: "PUT",
    data: $(e.target).closest("form").serializeJSON()
  })
  console.log('开启');
})
