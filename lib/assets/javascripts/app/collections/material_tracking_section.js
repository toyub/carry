
(function(win, doc, Backbone, $$MIS){
  var MaterialTrackingSectionCollection = Backbone.Collection.extend({
    model: function(attrs, options){
      return new $$MIS.MaterialTracking(attrs, options);
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSectionCollection = MaterialTrackingSectionCollection;
})(window, document, Backbone, window.$$MIS);
