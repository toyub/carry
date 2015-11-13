jQuery(function(){
  /*
  *TODO: make this to be a jQuery widget
  */
  var get_onshow_select = function(){
    return $('.as_select.onshow');
  }

  var hide_others = function(current) {
    get_onshow_select().each(function(){
      if(this != current) $(this).trigger('to_hide');
    });
  }

  $(document).on('click', function(evt){
    var current_select = get_onshow_select();
    if($(evt.target).closest('.select').length < 1 ){
      current_select.trigger('to_hide');
    }
  });

  jQuery.fn.extend({
    as_select: function(){
      return this.each(function(idx, el, undef){/* this==el ;true*/
        var $this = $(this);
        var selector = $(this.dataset.select);
        var target = $(this.dataset.target);

        selector.source = $this;

        this.onclick = function(evt){
          evt.stopPropagation();
          hide_others(this);
          if(selector.css('display') == 'none'){
            var b_c_r = this.getBoundingClientRect();
            var this_position = $this.position();
            selector.css({top: this_position.top+b_c_r.height, left: this_position.left})
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
          target.val(this.dataset.value).trigger('change', {value: this.dataset.value});
          $this.html(this.innerHTML);
          $this.trigger('selected');
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
    }
  });

  $('.as_select').as_select();

/*End of jQuery(function(){});*/
});
