(function(win, doc, Backbone, $$MIS){
  var SearchView = Backbone.View.extend({
    events: {

    },
    template: JST["kucun/material_orders/new/search"]
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialOrderSearchView = SearchView;
})(window, document, Backbone, window.$$MIS);
