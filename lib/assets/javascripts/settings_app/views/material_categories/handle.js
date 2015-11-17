(function(win, doc, Backbone, $$MIS){
  var MaterialCategoriesHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.urlRoot = opt.urlRoot;
    },
    events: {
      'click .new_category_btn': 'add'
    },
    add: function(evt){
      var model = new $$MIS.MaterialCategory;
      var form = new $$MIS.MaterialCategoryView({model: model});
      this.$el.find('.categories').append(form.render())
    },
    load: function(){
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoriesHandleView = MaterialCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
