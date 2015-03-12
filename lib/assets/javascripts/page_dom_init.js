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

  var get_onshow_select = function(){
    return $('.as_select.onshow');
  }

  var hide_others = function(current) {
    get_onshow_select().each(function(){
      if(this != current) $(this).trigger('to_hide');
    });
  }

  $('.as_select').each(function(idx){
    var $this = $(this);
    var selector = $(this.dataset.select);
    var target = $(this.dataset.target);
    var span_height=33;
    selector.css({top: $this.position().top+span_height, left: $this.position().left})
    selector.source = $this;
    
    this.onclick = function(evt){
      evt.stopPropagation();
      hide_others(this);
      if(selector.css('display') == 'none'){
        selector.show();
        $this.removeClass('onhide').addClass('onshow');
      }else{
        selector.hide();
        $this.removeClass('onshow').addClass('onhide');
      }
    }

    selector.on('click', 'li', function(evt){
      evt.stopPropagation();  
      selector.hide();
      selector.source.removeClass('onshow').addClass('onhide');
      target.val(this.dataset.value);
      $this.html(this.innerHTML);
    });

    selector.on('click', 'a.add_btn', function(evt){
      evt.stopPropagation();
      window.$$MIS.methods.get(this.dataset.method).apply(this);
    });

    $this.on('to_hide', function(evt){
      $(evt.target).removeClass('onshow').addClass('onhide');
      $(evt.target.dataset.select).hide();
    });
  });

  $(document).on('click', function(evt){
    var current_select = get_onshow_select();
    if($(evt.target).closest('.select').length < 1 ){
      current_select.trigger('to_hide');
    }
  });

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
      
    },

    add_category1: function(){

      var category_view = new $$MIS.MaterialCategoryView({model: new $$MIS.MaterialCategory()});
      console.log(category_view.template.call(category_view.model))
    },

    add_unit: function(){
      $('#modal_dialog').html("<iframe src='/kucun/material_units/new' frameborder=0></iframe>").dialog({modal: true});
    }
  }
});