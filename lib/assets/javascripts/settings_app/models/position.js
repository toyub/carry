(function(win, doc, Backbone, $$MIS){
  var Position = Backbone.Model.extend({
    defaults: {
      name: '新建职位',
      staff: []
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Position = Position;
})(window, document, Backbone, window.$$MIS);
