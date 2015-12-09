
(function(win, doc, Backbone, $$MIS){
  var MaterialTrackingSectionCollection = Backbone.Collection.extend({
    model: $$MIS.MaterialTrackingSection
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSectionCollection = MaterialTrackingSectionCollection;
})(window, document, Backbone, window.$$MIS);
