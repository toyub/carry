
(function(win, doc, Backbone, $$MIS){
  var MaterialCategoryCollection = Backbone.Collection.extend({
    rootUrl: '/kucun/material_categories/',

    model: function(attrs, options){
      return new $$MIS.MaterialCategory(attrs, options);
    },

    sub_categories: function(id, callback){
      this.url = this.rootUrl + id +'/sub_categories';
      var that = this;
      this.fetch({
        success: function(c, r, opt){
          callback.call(that, c, r, opt);
        }
      });
    },

    to_options: function(){
      return this.models.map(function(m){
        return '<li data-value="'+ m.get('id') +'">'+ m.get('name') +'</li>';
      }).join('');
    }

  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoryCollection = MaterialCategoryCollection;
})(window, document, Backbone, window.$$MIS);

