jQuery(function($){
  $(window.document).on("click", 'input.toggleable', function(){
     if(this.dataset.checked){
       this.checked = false;
       this.dataset.checked = '';
       $("[data-id='"+this.dataset.target+"']").attr('disabled', true);
     }else{
       this.checked = true;
       this.dataset.checked = 'checked';
       $("[data-id='"+this.dataset.target+"']").removeAttr('disabled');
       $("[data-id='"+this.dataset.target+"']").first().focus();
     }
  });

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
      div.style.top = '-1px';
      div.style.left = '115px';
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

    $('a.add_img').on('click', function(){$('#piccut').show();});
    $('input.btn-cancel').on('click', function(){$('#piccut').hide();});

    $('#material_img_thumbnails').on('click', 'li>img', function(evt){
      if(!$("#material_img_preview>img").length){
        var img = new Image();
        img.src = this.src;
        $("#material_img_preview").append(img);
      }else{
        $("#material_img_preview>img")[0].src = this.src;
      }
    });

  })(window, document);
  /*Image upload _END_*/

  /*
  *TODO: In some cases, we hate whitespace.
  */
  $(document).on('change', 'input[type="text"]', function(){
    this.value = this.value.trim();
  });

  window.timeout_calls=[];
  window.timeout_calls.push(function(){
    var time = new Date();
    if(time.getSeconds()%59==0 && time.getMilliseconds() < 10){
      console.log(new Date());
    }
  });

  window.requestAnimationFrame(function(){
    if(window.timeout_calls.length > 0){
      window.timeout_calls.forEach(function(el, idx, self, undef){
        el.call(this);
      });
    }
    window.requestAnimationFrame(arguments.callee);
  });

  var $$MIS=window.$$MIS || {};
  $$MIS.methods={
    get: function(method_name){
      if(!method_name)return function(){console.error('Invalid method name!')}
      if(this[method_name]){return this[method_name];}else{return function(){console.log("Method #" + method_name + ' is not defined!')}}
    },

    add_category: function(){
      var parent_id = $('#material_category1').val();
      if(!parent_id){
        $('#modal_dialog').html('请先选择一级分类').dialog({modal: true});
        return false;
      }
      $('#modal_dialog').html("<iframe src='/kucun/material_categories/"+ parent_id +"/add_sub_category' frameborder=0></iframe>").dialog({modal: true});
    },

    add_category1: function(){
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

    add_category1_callback: function(){
      var dialog = $('#modal_dialog').dialog('instance');
      $("#material_category1_select > ol").append("<li data-value="+ this.id +">" + this.name + "</li>")
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
    }
  }
});