(function(win, doc, Backbone, $$MIS){
  var CustomerCategory = Backbone.Model.extend({
    defaults: {
      color: '#000000'
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategory = CustomerCategory;
})(window, document, Backbone, window.$$MIS);
