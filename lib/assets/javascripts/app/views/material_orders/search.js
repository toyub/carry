(function(win, doc, Backbone, $$MIS){
  var SearchView = Backbone.View.extend({
    events: {
      'click .search_btn': 'search',
      'click .save_btn': 'showResult',
      'mouseover span.do_see_search': 'showKeywordInput',
      'click .doclose,.cancel_btn': 'hideSearch'
    },

    initialize:function(opt){
      this.materials = opt.materials;
      this.resultList = opt.resultList;
      this.keywordform = this.$el.find('.select_ordergoods_div');
      this.choices = opt.choices;
      this.listenTo(this.materials, 'sync', this.render);
      this.listenTo(this.materials, 'add', this.addOne);
      this.listenTo(this.materials, 'reset', this.resetResult);
    },

    showKeywordInput: function(evt){
      this.keywordform.show();
    },

    showResult: function(){
      var self = this;
      var els = [];
      this.materials.where({chosen: true}).forEach(function(model) {
        if(!self.choices.findWhere({id: model.id})){
          var view = new $$MIS.MaterialOrderChoiceView({
            model: model.clone()
          });
          view.model.set('price', model.get('cost_price'));
          view.model.set('quantity', 1);
          self.choices.add(view.model);
          els.push(view.render());
        }
      });
      this.trigger('done', els);
      this.hideSearch();
    },

    hideSearch: function(){
      this.$el.hide();
    },

    resetResult: function(){
      this.$el.find('.material_list').html('');
    },

    addOne: function(material){
      var view = new $$MIS.OrderMaterialView({model: material});
      this.$el.find('.material_list').append(view.render().el);
    },

    search: function(keyword){
      var keyword = this.$el.find('input.keyword')[0];
      if(!keyword.value.trim()){
        keyword.setCustomValidity("please input keyword");
        alert("please input keyword");
        return false;
      }
      this.materials.reset();
      this.keywordform.hide();
      this.materials.url = `/ajax/store_materials.json?name=${keyword.value.trim()}`;
      this.materials.fetch();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialOrderSearchView = SearchView;
})(window, document, Backbone, window.$$MIS);
