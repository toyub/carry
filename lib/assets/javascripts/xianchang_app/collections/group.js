(function(win, doc, Backbone, $$MIS){
  var GroupCollection = Backbone.Collection.extend({
    model: $$MIS.Group
  });
  win.$$MIS.GroupCollection = GroupCollection;
})(window, document, Backbone, window.$$MIS);
