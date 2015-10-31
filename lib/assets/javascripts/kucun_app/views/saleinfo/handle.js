(function(win, doc, Backbone, $$MIS){
  var SaleinfoHandleView = Backbone.View.extend({
    tagName: 'body',
    events:
      'add_server_btn'
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoHandleView = SaleinfoHandleView;
})(window, document, Backbone, window.$$MIS);
