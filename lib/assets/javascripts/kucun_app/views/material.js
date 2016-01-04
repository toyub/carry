(function(win, doc, Backbone, $$MIS){
  var NewMaterialView = Backbone.View.extend({
    el: 'body',
    initialize: function(options){
      if(options.el){this.setElement(options.el)}
      this.model = options.model;
      this.urlRoot = options.urlRoot;
      this.category_collection = new  $$MIS.MaterialCategoryCollection();
      this.listenTo(this.model, 'invalid', this.invalid_handle);
    },
    events: {
      'change [name]': "set_attr",
      'change input[name="material[store_material_root_category_id]"]': 're_render_subs',
      'selected span.as_select': 'selected_handle',
      'submit #material_form': 'save'
    },

    set_attr: function(evt){
      var input = evt.currentTarget;
      var name = input.name.match(/\[(.*)\]/)[1];
      var value = input.value;
      if(input.type.toLowerCase() == 'checkbox'){
        value = !!input.checked;
      }
      if(!!name){
        this.model.set(name, value);
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

    invalid_handle: function(model, errors, options){
      this.error_length = errors.length;
      var _this = this;
      errors.forEach(function(error){
        _this.error_handle(error);
      });
    },

    error_handle: function(error){
      var $field_tag = this.$el.find("#" + error.attr);
      var field_tag = $field_tag[0];
      var field_tag_rect = field_tag.getBoundingClientRect();
      var position = $field_tag.position();
      $field_tag.addClass('error');

      var error_tag = $("<div>").addClass('field_error field_down')
                    .addClass(error.attr)
                    .html(error.msg)
                    .css({
                        top: (position.top - field_tag_rect.height) + 'px',
                        left: position.left + 'px'
                    });

      $field_tag.after(error_tag);
    },

    selected_handle: function(evt){
      var $this = $(evt.currentTarget);
      var this_el=this.$el;
      var error = this.error_length;
      if($this.hasClass('error')){
        $this.removeClass('error');
        $("div." + $this.attr('id')).hide();
        this.error_length = error - 1;
      }
    },
    save: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      var _this = this;
      if(this.error_length){return false;}
      if(!this.model.isValid()){return false;}
      this.model
          .save()
          .success(function(data, status_msg, ajax, undef){/* *this=ajax */
            var form_url = _this.model.url() + '/save_picture';
            var redirect_to = _this.model.url();
            var uploading_imgs = $('#preview_list > img:not(.cached)');
            if(uploading_imgs.length > 0){
              uploading(uploading_imgs,form_url,redirect_to);
            }else{
              window.location.replace(redirect_to);
            }
          })
          .error(function(data){alert('error')});
      return false;
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.NewMaterialView = NewMaterialView;
})(window, document, Backbone, window.$$MIS);
