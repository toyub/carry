var customers_in_sas = {

  showColorsPicker : function(e){
    $(e.target).parents("ul").next().slideDown();
    $(e.target).parent().addClass("changing_bg_color");
  },

  changeBgColor : function(e){
    $(e.target).parent().prev().attr("class", $(e.target).attr("class"));
  },

  hideColorsPicker : function(e){
    $(e.target).parents("ul").next().slideUp();
    $(e.target).parent().removeClass("changing_bg_color");
  },

  editGraphName : function(e){
    var value = $(e.target).parents("ul").find("label").text();
    $(e.target).parent().siblings().addClass("editing").find("input").focus().val(value);
    $(e.target).parent().addClass("changing_name");
  },

  editName : function(e){
    var value = $(e.target).parents("ul").find(".active label").text();
    $(e.target).parents("ul").find(".active").addClass("editing").find("input").focus().val(value);
    $(e.target).parent().addClass("changing_name");
  },

  saveGraphName : function(e){
    var value = $(e.target).parents("ul").find("input").val();
    $(e.target).parent().siblings().removeClass("editing").find("label").text(value);
    $(e.target).parent().removeClass("changing_name");
  },

  saveName : function(e){
    var value = $(e.target).parents("ul").find(".active input").val();
    $(e.target).parents("ul").find(".active").removeClass("editing").find("label").text(value);
    $(e.target).parent().removeClass("changing_name");
  },

  deleteGraph : function(e){
    $(e.target).parents(".do_graph").remove();
  },

  hideGraph : function(e){
    $(e.target).parent().addClass("hide");
    $(e.target).parents(".do_graph").find(".do_chart").slideUp("fast");
  },

  showGraph : function(e){
    $(e.target).parent().removeClass("hide");
    $(e.target).parents(".do_graph").find(".do_chart").slideDown("fast");
  },

  activate : function(e){
    $(e.target).parent("div").addClass("active").siblings().removeClass("active");
  }
}

var top_editors = function(){
  $(".fa-minus").click(customers_in_sas.hideGraph);
  $(".fa-plus").click(customers_in_sas.showGraph);
}

$(".lnr-drop").click(customers_in_sas.showColorsPicker);

$(".colors_picker span").click(customers_in_sas.changeBgColor);

$(".js_save_color").click(customers_in_sas.hideColorsPicker);

$(".js_edit_name").click(customers_in_sas.editGraphName);

$(".js_save_name").click(customers_in_sas.saveGraphName);

$(".fa-times").click(customers_in_sas.deleteGraph);

$(".fa-minus").click(customers_in_sas.hideGraph);

$(".fa-plus").click(customers_in_sas.showGraph);

$(".do_edit_name").click(customers_in_sas.editName);

$(".do_save_name").click(customers_in_sas.saveName);

$(".do_graph ul li div label").click(customers_in_sas.activate);
