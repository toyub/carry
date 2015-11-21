(function(win, doc, Backbone, $$MIS){
  var CustomerCategoriesHandleView = Backbone.View.extend({
    el: 'body',
    events: {
      'click .new_customer_btn': 'add'
    },
    add: function(evt){
      $('.customer_setting_wrap').hide();
      var model = new $$MIS.CustomerCategory();
      var form_view = new $$MIS.CustomerCategoryFormView({model: model});
      $('#categories').append(form_view.render());
      $('#categories_names').append(form_view.name_el);
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoriesHandleView = CustomerCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
