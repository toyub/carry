jQuery(function($){
  $(window.document).on("click", 'input[type="radio"].toggleable', function(){
     if(this.dataset.checked){
       this.checked = false;
       this.dataset.checked = '';
       $("[data-id='"+this.dataset.target+"']").attr('disabled', true);
     }else{
       this.checked = true;
       this.dataset.checked = 'checked';
       $("[data-id='"+this.dataset.target+"']").removeAttr('disabled');
     }
  });

  $(document.body).append('<div style="display:none;" id="modal_dialog"></div>');

  /*
  *TODO: In some cases, we hate whitespace.
  */
  $(document).on('change', 'input', function(){
    this.value = this.value.trim();
  });

  var $$MIS=window.$$MIS || {};
  $$MIS.methods={
    get: function(method_name){
      if(!method_name)return function(){console.error('Invalid method name!')}
      if(this[method_name]){
        return this[method_name];
      }else{
        return function(){console.log("Method #" + method_name + ' is not defined!')}
      }
    },

    add_category: function(){
      var parent_id = $('#material_category1').val();
      $('#modal_dialog').html("<iframe src='/kucun/material_categories/"+ parent_id +"/add_sub_category' frameborder=0></iframe>").dialog({modal: true});
    },

    add_category1: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_categories/new' frameborder=0></iframe>").dialog({modal: true});
    },

    add_brand: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_brands/new' frameborder=0></iframe>").dialog({modal: true});
    },

    add_manufacturer: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_manufacturers/new' frameborder=0></iframe>").dialog({modal: true});
    },

    add_unit: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_units/new' frameborder=0></iframe>").dialog({modal: true});
    },

    add_unit_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_unit_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },

    add_brand_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_brand_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },

    add_manufacturer_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_manufacturer_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },

    add_category1_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_category1_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },

    add_category_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_category_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    }
  }
});
