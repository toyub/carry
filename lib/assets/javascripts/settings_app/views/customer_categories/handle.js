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
      'click .add': 'addOne',
      'click .delete': 'delete'
    },
    addOne: function(){
      this.customer_categories.add({name: '新建类别'});
    },
    fetch: function(model){
      var controller = new $$MIS.CustomerCategoriesController(model, this);
      if(model.isNew()){
        $('.customer_setting_wrap').hide();
        controller.show();
      }else{
        controller.set_name_el();
      }
    },
    delete: function(evt){
      var button = evt.target;
      if(button.classList.contains('disabled')){return;}
      $('.selected').trigger('click:delete');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoriesHandleView = CustomerCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
