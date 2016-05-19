jQuery(function($){
  var outgo_tmpl = JST['report/material_outgos/index'];
  function outgos(){
    html = ""
    $.ajax({
      url: "/report/store_material_inventories/outgos",
      dataType: "json",
      type: 'get',
      success: function(data){
        $("table#storage_tab").html(outgo_tmpl(data))
        $("div.main_top").html("<h2>报表>出库记录</h2>")
      }
    })
  };

  $(document).on('click', 'a.js-material-outgo', function(){
    outgos();
  });
});
