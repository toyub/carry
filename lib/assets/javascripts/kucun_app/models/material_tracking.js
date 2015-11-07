(function(win, doc, Backbone, $$MIS){
  var MaterialTracking = Backbone.Model.extend({
    defaults: {},
    validate: function(attrs, options){},
    url: function(){
      return this.urlRoot;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTracking = MaterialTracking;
})(window, document, Backbone, window.$$MIS);
