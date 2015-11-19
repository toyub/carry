(function(win, doc, Backbone, $$MIS){
  var OrganizationalStructuresHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.urlRoot = opt.urlRoot;
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.OrganizationalStructuresHandleView = OrganizationalStructuresHandleView;
})(window, document, Backbone, window.$$MIS);
