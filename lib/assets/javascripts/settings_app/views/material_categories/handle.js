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
      var form = new $$MIS.MaterialCategoryView({model: model});
      this.$el.find('.categories').append(form.render());
      model.attributes.sub_categories.forEach(function(m, idx){
        form.fetch_sub(m);
      })
    },
    add: function(evt){
      var model = new $$MIS.MaterialCategory;
      var form = new $$MIS.MaterialCategoryView({model: model});
      this.$el.find('.categories').append(form.render())
    },
    load: function(){
      this.categories.url = this.urlRoot + '/fetch';
      this.categories.fetch();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoriesHandleView = MaterialCategoriesHandleView;
})(window, document, Backbone, window.$$MIS);
