jQuery(function($){
  $(document.body).append('<div style="display:none;" id="modal_dialog"></div>');

  /*Image upload _BEGIN_*/
  (function(window, document){
    var imgfile=document.getElementById("imgfile");
    if(!imgfile){return false;}
    var fr = new FileReader();
    fr.onload = function(e){
      if(document.getElementById('image_tag')){
        document.getElementById('image_tag').remove();
      }
      document.getElementById("gallery").remove();

      var image = new Image();
      image.className = "resize-image";
      image.id = 'image_tag';
      image.src = this.result;

      div = document.createElement("div");
      div.id='gallery';
      div.className = 'resize-container';
      div.appendChild(image);
      document.getElementById('arrange').appendChild(div);

      var dataid=$('#material_img_thumbnails').data('id');
      var preview = $("#preview_list");
      resizeableImage(document.getElementById('image_tag'), $('.js-crop')[0], preview);
    }

    imgfile.onchange = function(e){
       f1 = this.files.item(0);
      if(f1.type == 'image/png' || f1.type == 'image/jpeg'){
        fr.readAsDataURL(f1, 'image/png');
      }else{
        alert('错误的文件格式，请选择PNG或JPG格式的图片文件！');
        this.value = '';
      }
    }

    $('a.add_img').on('click', function(){
      $('#piccut').show();
      if($('#preview_list>img').length >= 4){
        $('a.add_img').hide();
      }
    });
    $('input.btn-cancel').on('click', function(){$('#piccut').hide();});

  })(window, document);
  /*Image upload _END_*/

  /*
  *TODO: In some cases, we hate whitespace.
  */
  $(document).on('change', 'input[type="text"]', function(){
    this.value = this.value.trim();
  });

  var $$MIS=window.$$MIS || {};
  $$MIS.methods={
    get: function(method_name){
      if(!method_name)return function(){console.error('Invalid method name!')}
      if(this[method_name]){return this[method_name];}else{return function(){console.log("Method #" + method_name + ' is not defined!')}}
    },

    add_category: function(){
      var parent_id = $('input[name="material[store_material_root_category_id]"]').val();
      if(!parent_id){
        $('#modal_dialog').html('请先选择一级分类').dialog({modal: true});
        return false;
      }
      $('#modal_dialog').html("<iframe src='/kucun/material_categories/"+ parent_id +"/add_sub_category' frameborder=0></iframe>").dialog({modal: true});
    },

    add_root_category: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_categories/new' frameborder=0  ></iframe>").dialog({modal: true});
    },

    add_brand: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_brands/new' frameborder=0  ></iframe>").dialog({modal: true});
    },

    add_manufacturer: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_manufacturers/new' frameborder=0 ></iframe>").dialog({modal: true});
    },

    add_unit: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_units/new' frameborder=0></iframe>").dialog({modal: true});
    },

    add_supplier:function(){
      $('#modal_dialog').html("<iframe src='/kucun/store_suppliers/new' frameborder=0></iframe>").dialog({modal: true});
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

    add_root_category_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_root_category_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },

    add_category_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_category_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },

    add_supplier_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_supplier_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    },

    add_saleinfo_category: function(){
        $('#modal_dialog').html("<iframe src='/kucun/material_saleinfo_categories/new' frameborder=0></iframe>").dialog({modal: true});
     },

    add_material_saleinfo_category_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#saleinfo_category_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
      dialog.destroy();
    }
  }
});
