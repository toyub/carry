(function(win, doc, Backbone, $$MIS){
  var NewMaterialView = Backbone.View.extend({
    events: {
      'change [name]': "set_attr",
      'change input[name="material[store_material_root_category_id]"]': 're_render_subs',
      'selected span.as_select': 'selected_handle'
    },

    set_attr: function(evt){
      var input = evt.currentTarget;
      var name = input.name.match(/\[(.*)\]/)[1];
      if(!!name){
        this.model.set(name, input.value);
      }
    },

    re_render_subs: function(evt, data){
      var this_el = this.$el;
      this.category_collection.sub_categories(data.value, function(c, r, opt){
        this_el.find('input[name="material[store_material_category_id]"]').val('').trigger('change');
        this_el.find("span[data-select='#material_category_select']").html('请选择');
        this_el.find("#material_category_select > ol").html(this.to_options());
      })
    },

    invalid_handle: function(model, errors){
      var this_el = this.view.$el;
      this.view.$el.data('error', errors.length);
      var this_view = this.view;
      errors.forEach(function(error){
        this_el.find("#" + error.attr).addClass('error');
        this_view.error_handle(this_el.find("#" + error.attr), error);
      });
    },

    error_handle: function(el, error){
      var position = el.position();
      var span_height = 39;
      var ss=$('.new_products').position() || {top: 0, left:0};

      x = $("<div class='field_error field_down "+ error.attr +"'></div>").html(error.msg)
      x.css({
        top: (position.top - ss.top - el[0].getBoundingClientRect().height) + 'px',
        left: position.left + 'px'
      })

      el.after(x);
    },

    selected_handle: function(evt){
      var $this = $(evt.currentTarget);
      var this_el=this.$el;
      var error = parseInt(this_el.data('error'));
      if($this.hasClass('error')){
        $this.removeClass('error');
        $("div." + $this.attr('id')).hide();
      }
      if(error > 1){
        this_el.data('error', error - 1)
      }else{
        this_el.data('error', '');
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.NewMaterialView = NewMaterialView;
})(window, document, Backbone, window.$$MIS);