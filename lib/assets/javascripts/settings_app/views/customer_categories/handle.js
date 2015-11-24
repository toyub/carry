(function(win, doc, Backbone, $$MIS){
  var CustomerCategoriesHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.material_categories = opt.material_categories;
      this.service_categories = opt.service_categories;
      this.urlRoot = opt.urlRoot;
    },
    events: {
      'click .add': 'add'
    },
    add: function(evt){
      $('.customer_setting_wrap').hide();
      var controller = new $$MIS.CustomerCategoriesController(null, this);
      controller.show();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoriesHandleView = CustomerCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
