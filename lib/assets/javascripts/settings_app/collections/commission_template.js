(function(win, doc, Backbone, $$MIS){
  var CommissionTemplateCollection = Backbone.Collection.extend({
    model: $$MIS.CommissionTemplate
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateCollection = CommissionTemplateCollection;
})(window, document, Backbone, window.$$MIS);
