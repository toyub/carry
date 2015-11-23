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
      'click .service_categories li': 'show_services'
    },
    render: function(){
      this.$el.html(tmpl(this.model.attrs()));
      this.name_el = $('<li>').html('新建客户类别');
      return this.$el;
    },
    save: function(evt){
      evt.preventDefault();
      var $form = $(evt.target)
      console.log($form.serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true}))
    },
    reset: function(evt){
      evt.preventDefault();
    },
    show_sub: function(evt){
      var id = evt.target.dataset.id;
      var disc = this.$el.find('.product_category [data-parentid=' + id + ']');
      this.$el.find('.product_category .secondary_category').hide();
      if(disc.length > 0){
        disc.show();
      }else{
        var category  = this.model.material_categories.find(function(cate){return cate.id == id;});
        var html = mcd_tmpl({id: id, categories: category.sub_categories});
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
          var html = sd_tmpl({id: id, categories: data});
          _this.$el.find('.service_category').append(html)
        });
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoryFormView = CustomerCategoryFormView;
})(window, document, Backbone, window.$$MIS);
