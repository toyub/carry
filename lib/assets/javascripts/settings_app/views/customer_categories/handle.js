(function(win, doc, Backbone, $$MIS){
  var CustomerCategoriesHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.material_categories = opt.material_categories;
      this.service_categories = opt.service_categories;
    },
    events: {
      'click .add': 'add'
    },
    add: function(evt){
      $('.customer_setting_wrap').hide();
      var model = new $$MIS.CustomerCategory();
      model.material_categories = this.material_categories;
      model.service_categories = this.service_categories;
      var form_view = new $$MIS.CustomerCategoryFormView({model: model});
      $('#categories').append(form_view.render());
      $('#categories_names').append(form_view.name_el);
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoriesHandleView = CustomerCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
