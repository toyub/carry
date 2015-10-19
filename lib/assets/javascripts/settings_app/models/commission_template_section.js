(function(win, doc, Backbone, $$MIS){
  var CommissionTemplateSection = Backbone.Model.extend({
    defaults: {
      type_id: 0
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateSection = CommissionTemplateSection;
})(window, document, Backbone, window.$$MIS);
