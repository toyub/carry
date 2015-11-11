(function(win, doc, Backbone, $$MIS){
  var Depot = Backbone.Model.extend({
    defaults: {
      name: '',
      description: '',
      created_at: new Date(),
      preferred: false,
      creator: '',
      admin_ids: [],
      useable: true,
      deleted: false
    },

    created_on: function(){
      var created_at = this.get('created_at');
      if(created_at){
        if(created_at.constructor.name == 'Date'){
          return created_at.toISOString().split('T')[0];
        }else{
          return created_at.split('T')[0];
        }
      }

    },

    admins: function(){
      return this.get('admin_ids')
    },

    summary_attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.created_on = this.created_on();
      _attrs.admins = this.admins();
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Depot = Depot;
})(window, document, Backbone, window.$$MIS);
