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
      this.choices = opt.choices;
      this.listenTo(this.materials, 'sync', this.render);
      this.listenTo(this.materials, 'add', this.addOne);
      this.listenTo(this.materials, 'reset', this.resetResult);
    },
    showKeywordInput: function(evt){
        var target = evt.target;
        target.className="cursor-pointer do_hide_search";
        this.$el.find("li.first_td").addClass('see_search');
    },
    showResult: function(){
      var self = this;
      var els = [];
      this.materials.where({chosen: true}).forEach(function(model) {
        var view = new $$MIS.MaterialOrderChoiceView({
          model: model.clone()
        });
        self.choices.add(view.model);
        els.push(view.render());
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

    render: function(){
      console.log(2232)
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
      this.$el.find(".do_hide_search")[0].className="cursor-pointer do_see_search";
      this.$el.find("li.first_td").removeClass('see_search');
      this.materials.url = `/ajax/store_materials.json?name=${keyword.value.trim()}`;
      this.materials.fetch();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialOrderSearchView = SearchView;
})(window, document, Backbone, window.$$MIS);
