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

    admin_ids: function(){
      return this.get('admin_ids')
    },

    toggle_useable: function(useable){
      if(typeof useable == typeof undefined){
        this.set('useable', !this.get('useable'));
      }else{
        this.set('useable', !!useable);
      }
      $.ajax({
        url: this.url() + '/toggle_useable',
        type: 'PUT'
      });
    },

    prefer: function(preferred){
      if(typeof preferred == typeof undefined){
        this.set('preferred', !this.get('preferred'))
      }else{
        this.set('preferred', preferred);
      }
      $.ajax({
        url: this.url() + '/prefer',
        type: 'PUT'
      });
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
