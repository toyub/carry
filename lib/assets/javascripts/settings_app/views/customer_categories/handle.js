(function(win, doc, Backbone, $$MIS){
  var CustomerCategoriesHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.material_categories = opt.material_categories;
      this.service_categories = opt.service_categories;
      this.urlRoot = opt.urlRoot;
      this.customer_categories = new $$MIS.CustomerCategoryCollection();
      this.customer_categories.url =  this.urlRoot;
      this.listenTo(this.customer_categories, 'add', this.fetch)
      this.customer_categories.fetch();
    },
    events: {
      'click .add': 'add'
    },
    add: function(evt){
      $('.customer_setting_wrap').hide();
      var controller = new $$MIS.CustomerCategoriesController(null, this);
      controller.show();
    },
    fetch: function(model){
      var controller = new $$MIS.CustomerCategoriesController(model, this);
      controller.set_name_el();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoriesHandleView = CustomerCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
