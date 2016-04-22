jQuery(function($){
  $(document.body).append('<div style="display:none;" id="modal_dialog"></div>');

  console.log($("#modal_diablog"));
  $(document).on('change', 'input[type="text"]', function(){
    this.value = this.value.trim();
  });

  var $$MIS=window.$$MIS || {};
  $$MIS.methods={
    get: function(method_name){
      if(!method_name)return function(){console.error('Invalid method name!')}
      if(this[method_name]){return this[method_name];}else{return function(){console.log("Method #" + method_name + ' is not defined!')}}
    },

    add_unit: function(){
      console.log("hello");
      $('#modal_dialog').html("<iframe src='/kucun/material_units/new' frameborder=0></iframe>").dialog({modal: true});
    },

    add_unit_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_unit_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },
  }
});
