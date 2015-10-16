(function(win, doc, Backbone, $$MIS){
  var CommissionTemplate = Backbone.Model.extend({
    defaults: {
      type_id: 0
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplate = CommissionTemplate;
})(window, document, Backbone, window.$$MIS);
