jQuery(function($){
  $(document).on("click", "i.ico.ico-edit.do_complaints", function(){
    clearChecked()
    $("div.window_wrap").show();
    $('form#complain_form').attr('action', "/crm/store_customers/"+ $(this).data("customer") +"/complaints/"+ $(this).data("complaint") +"");
    $.get("/crm/store_customers/"+ $(this).data("customer") +"/complaints/"+ $(this).data("complaint") +"/edit", function(data){
      callBack(data)
    });
  });

  $("a.btn.cancel_btn").on("click", function(){
    $("div.window_wrap").hide();
    $("ul#complaint-saler").html("");
    $("ul#complaint-mechanics").html("");
  });

  function callBack(data){
    checkedCategory(data)
    checkedWay(data)
    appendContent(data);
    setPrincipalChecked(data);
    BasicInfo(data);
  };

  function BasicInfo(data){
    $.each(data,function(key,value) {
      $(".js-"+key).text(value);
     });
    $("input.satisfaction-"+data.satisfaction).prop("checked",'true');
  };

  function setPrincipalChecked(data){
    $("input[name='complaint[detail][principal][saler]']").prop("checked", data.saler.selected);
    data.mechanics.forEach(function(item){
      $("input.mechanic-"+ item).prop("checked",'true');
    });
  };

  function appendContent(data){
    $("ul#complaint-saler").append("<li><label>"+ data.saler.name +"<input name='complaint[detail][principal][saler]' type='checkbox' value="+ data.saler.id +" ></label></li>")
    data.order_mechanics.forEach(function(item){
      var html = "<li><label>";
      html += item.name;
      html += "<input name='complaint[detail][principal][mechanics][]' type='checkbox' class='mechanic-";
      html += item.id;
      html += "' value=";
      html += item.id;
      html += "></label></li>";
      $("ul#complaint-mechanics").append(html);
    });
  };

  function clearChecked(){
    $("input:checkbox").prop("checked", false);
  };

  function checkedCategory(data){
    data.categoried.forEach(function(item){
      $("input.category-checkbox-" + item).prop("checked",'true')
    });
  };

  function checkedWay(data){
    data.ways.forEach(function(item){
      $("input.way-checkbox-" + item).prop("checked",'true')
    });
  };

})
