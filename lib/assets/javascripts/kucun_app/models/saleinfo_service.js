(function(win, doc, Backbone, $$MIS){
  var SaleinfoService = Backbone.Model.extend({
    defaults: {

    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoService = SaleinfoService;
})(window, document, Backbone, window.$$MIS);
