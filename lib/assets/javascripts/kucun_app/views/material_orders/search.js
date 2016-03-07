(function(win, doc, Backbone, $$MIS){
  var SearchView = Backbone.View.extend({
    events: {
      'click .search_btn': 'search',
      'click .save_btn': 'showResult',
      'click .add_material': 'add_material',
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

    add_material: function(){
      var _this = this;
      var template = document.getElementById('new_material_template');
      this.$el.hide();
      new_m_v = new $$MIS.NewMaterialView({urlRoot: "/kucun/materials/",
                                           el: $('<div>').addClass('popup_box'),
                                           model: new $$MIS.Material()
                                         });
      new_m_v.$el.html(template.innerHTML);
      new_m_v.$el.appendTo($('body'));
      new_m_v.$el.find('.as_select').as_select();
      new_m_v.$el.on('submit', 'form', function(evt){
        evt.preventDefault();
        if(!new_m_v.model.isValid()){
          return false;
        }
        new_m_v.model.save()
                     .success(function(data){
                       new_m_v.$el.hide();
                       _this.$el.show();
                       _this.materials.add(new_m_v.model)
                     })
                     .error(function(){alert('error');});
        return false;
      });
      new_m_v.$el.on("click", '.doclose,.cancel_btn', function(event){
        delete new_m_v.model;
        new_m_v.$el.hide();
        new_m_v.$el.remove();
        delete new_m_v;
        _this.$el.show();
      });
      new_m_v.$el.show();
    },

    search: function(keyword){
      var keyword = this.$el.find('input.keyword')[0];
      this.materials.reset();
      this.keywordform.hide();
      this.materials.url = "/ajax/store_materials.json?name="+keyword.value.trim();
      this.materials.fetch();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialOrderSearchView = SearchView;
})(window, document, Backbone, window.$$MIS);
