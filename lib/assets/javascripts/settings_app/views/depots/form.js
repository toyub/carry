(function(win, doc, Backbone, $$MIS){
  var DepotFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'new_warehouse_wrap',
    template: JST['settings/depots/new/form']
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotFormView = DepotFormView;
})(window, document, Backbone, window.$$MIS);
