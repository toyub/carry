(function(win, doc, Backbone, $$MIS){
  var MaterialCategoriesHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.urlRoot = opt.urlRoot;
      this.categories = new $$MIS.MaterialCategoryCollection();
      this.listenTo(this.categories, 'add', this.fetchOne);
      this.load();
    },
    events: {
      'click .new_category_btn': 'add'
    },
    fetchOne: function(model){
      var category_view = new $$MIS.MaterialCategoryView({model: model});
      category_view.model.urlRoot = this.urlRoot;
      this.$el.find('.categories').append(category_view.render());
      category_view.mount_subs();
    },
    add: function(evt){
      var model = new $$MIS.MaterialCategory;
      var category_view = new $$MIS.MaterialCategoryView({model: model});
      category_view.model.urlRoot = this.urlRoot;
      this.$el.find('.categories').append(category_view.render())
    },
    load: function(){
      this.categories.url = this.urlRoot + '/fetch';
      this.categories.fetch();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoriesHandleView = MaterialCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
