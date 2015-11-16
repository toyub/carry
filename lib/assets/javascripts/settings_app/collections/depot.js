(function(win, doc, Backbone, $$MIS){
  var DepotCollection = Backbone.Collection.extend({
    model: $$MIS.Depot,
    find_by_cid: function(cid){
      return this.find(function(model){
        return model.cid == cid;
      });
    },
    find_by_preferred: function(preferred){
      return this.where({preferred: preferred});
    },
    current_default: function(){
      return this.find_by_preferred(true)[0];
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotCollection = DepotCollection;
})(window, document, Backbone, window.$$MIS);
