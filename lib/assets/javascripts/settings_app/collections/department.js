(function(win, doc, Backbone, $$MIS){
  var DepartmentCollection = Backbone.Collection.extend({
    model: $$MIS.Department
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.DepartmentCollection = DepartmentCollection;
})(window, document, Backbone, window.$$MIS);
