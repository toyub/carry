jQuery(function($){
  $(document).on("click", "i.ico.ico-edit.do_complaints", function(){
    clearChecked()
    $("div.window_wrap").show();
    $('form#complain_form').attr('action', "/crm/store_customers/"+ $(this).data("customer") +"/complaints/"+ $(this).data("complaint") +"");
    $.get("/crm/store_customers/"+ $(this).data("customer") +"/complaints/"+ $(this).data("complaint") +"/edit", function(data){
      setCategoryWithWayChecked(data);
      appendContent(data);
      setPrincipalChecked(data);
      setBasicInfo(data);
    });
  });

  $("a.btn.cancel_btn").on("click", function(){
    $("div.window_wrap").hide();
    $("ul#complaint-saler").html("");
    $("ul#complaint-mechanic").html("");
  });

  function setBasicInfo(data){
    $("dd.dd-vehicle").text(data.license_number);
    $("dd.dd-order-numero").text(data.numero);
    $("textarea#complaint-content").text(data.content);
    $("textarea#complaint-inquire").text(data.inquire);
    $("textarea#response-customer").text(data.responses[0].customer);
    $("textarea#response-principal").text(data.responses[0].principal);
    $("input.satisfaction-"+data.satisfaction).prop("checked",'true');
    $("span#created_at").text(data.created_at);
  };

  function setPrincipalChecked(data){
    if(data.salers[0].select == data.salers[0].id){
      $("input[name='complaint[detail][principal][saler]']").prop("checked","true")
    };
    data.mechanic.forEach(function(item){
      $("input.mechanic-"+ item).prop("checked",'true');
    });
  };

  function appendContent(data){
    $("ul#complaint-saler").append("<li><label>"+ data.salers[0].name +"<input name='complaint[detail][principal][saler]' type='checkbox' value="+ data.salers[0].id +" ></label></li>")
    data.mechanics.forEach(function(item){
      var html = "<li><label>";
      html += item.name;
      html += "<input name='complaint[detail][principal][mechanic][]' type='checkbox' class='mechanic-";
      html += item.id;
      html += "' value=";
      html += item.id;
      html += "></label></li>";
      $("ul#complaint-mechanic").append(html);
    });
  };

  function clearChecked(){
    $("input:checkbox").prop("checked", false);
  };

  function setCategoryWithWayChecked(data){
    data.categoried.forEach(function(item){
      $("input.category-checkbox-" + item).prop("checked",'true')
    });
    data.way.forEach(function(item){
      $("input.way-checkbox-" + item).prop("checked",'true')
    });
  };

})
