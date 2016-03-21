(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['settings/customer_categories/form'];
  var mcd_tmpl = JST['settings/customer_categories/material_category_discount'];
  var sd_tmpl = JST['settings/customer_categories/service_discount'];

  var CustomerCategoryFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'customer_setting_wrap',
    events: {
      'submit form': 'save',
      'reset form': 'reset',
      'click .material_categories li': 'show_sub',
      'click .service_categories li': 'show_services',
      'click .forall_enabled': 'forall_enable',
      'change [type=range]': 'show_range'
    },
    render: function(){
      this.$el.html(tmpl(this.model.attrs()));
      return this.$el;
    },
    save: function(evt){
      evt.preventDefault();
      var $form = $(evt.target);
      $form.find('[type=checkbox]:checked').val(true);
      var attrs = $form.serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true, parseNumbers: true})
      this.model.set_attrs(attrs);
      var _this = this;
      this.model.save(null, {
        error: function(){
          ZhanchuangAlert('由于网络问题，保存到服务器失败，请重新保存！');
        }
      }).done(function(){
        _this.trigger('saved');
      });
    },
    reset: function(evt){
      evt.preventDefault();
      this.render();
      this.trigger('reseted');
    },
    show_sub: function(evt){
      var id = evt.target.dataset.id;
      var disc = this.$el.find('.product_category [data-parentid=' + id + ']');
      this.$el.find('.product_category .secondary_category').hide();
      if(disc.length > 0){
        disc.show();
      }else{
        var category  = this.model.material_categories.find(function(cate){return cate.id == id;});
        var html = mcd_tmpl({id: id, categories: category.sub_categories, discounts: this.model.get_material_categories_discount(id)});
        this.$el.find('.product_category').append(html)
      }
    },
    show_services: function(evt){
      var id = evt.target.dataset.id;
      var disc = this.$el.find('.service_category [data-parentid=' + id + ']');
      this.$el.find('.service_category .secondary_category').hide();
      if(disc.length > 0){
        disc.show();
      }else{
        var category  = this.model.material_categories.find(function(cate){return cate.id == id;});
        var _this = this;
        $.get('/settings/customer_categories/services?id='+id, function(data){
          var html = sd_tmpl({id: id, categories: data, discounts: _this.model.get_services_discount(id)});
          _this.$el.find('.service_category').append(html)
        });
      }
    },
    forall_enable: function(evt){
      var check = evt.target;
      if(check.checked){
        this.$el.find('[data-id='+ check.dataset.target +']').removeAttr('disabled')
        this.$el.find('.'+check.dataset.class+'[data-pid='+check.dataset.id+'] input[type=number]').attr('disabled', true);
      }else{
        this.$el.find('[data-id='+ check.dataset.target +']').attr('disabled', true)
        this.$el.find('.'+check.dataset.class+'[data-pid='+check.dataset.id+'] input[type=number]').removeAttr('disabled');
      }

    },
    show_range: function(evt){
      var target = evt.target;
      target.nextElementSibling.innerHTML = target.value + '%';
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoryFormView = CustomerCategoryFormView;
})(window, document, Backbone, window.$$MIS);
