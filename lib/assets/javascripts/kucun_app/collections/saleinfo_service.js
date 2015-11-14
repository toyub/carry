
(function(win, doc, Backbone, $$MIS){
  var SaleinfoServiceCollection = Backbone.Collection.extend({
    model: $$MIS.SaleinfoService
  });
  win.$$MIS.SaleinfoServiceCollection = SaleinfoServiceCollection;
})(window, document, Backbone, window.$$MIS);
