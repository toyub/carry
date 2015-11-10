(function(win, doc, Backbone, $$MIS){
  var DepotsHandleView = Backbone.View.extend({
    el: 'body'
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotsHandleView = DepotsHandleView;
})(window, document, Backbone, window.$$MIS);
