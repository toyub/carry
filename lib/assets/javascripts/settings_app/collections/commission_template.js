(function(win, doc, Backbone, $$MIS){
  var CommissionTemplateCollection = Backbone.Collection.extend({
    model: $$MIS.CommissionTemplate,
    find_by_cid: function(cid){
      return this.find(function(model){
        return model.cid == cid;
      });
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateCollection = CommissionTemplateCollection;
})(window, document, Backbone, window.$$MIS);
