(function(win, doc, Backbone, $$MIS){
  var NewOrderView = Backbone.View.extend({
    events: {
    },
    initialize: function(){
      this.search_view = new $$MIS.MaterialOrderSearchView({
        el: $('#pop_choose_goods'),
        resultList: $('#storage_tab'),
        materials: new $$MIS.MaterialCollection(),
        choices: new $$MIS.MaterialCollection()
      });
      var self = this;

      this.search_view.on('done', function(els){
        self.rerender(els);
      })
    },
    rerender:function(els){
      els.forEach(function(el){
        $('#storage_tab .handle').before(el);
      });
    }

  });
  win.$$MIS.NewMaterialOrderView = NewOrderView;
})(window, document, Backbone, window.$$MIS);
