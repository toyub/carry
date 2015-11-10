(function(win, doc, Backbone, $$MIS){
  var Depot = Backbone.Model.extend({
    defaults: {
      name: '',
      description: '',
      created_at: new Date(),
      preferred: false,
      creator: '',
      admins: [],
      useable: true,
      deleted: false
    },

    created_on: function(){
      var created_at = this.get('created_at');
      return created_at.toISOString().split('T')[0];
    },

    summary_attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.created_on = this.created_on();
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Depot = Depot;
})(window, document, Backbone, window.$$MIS);
