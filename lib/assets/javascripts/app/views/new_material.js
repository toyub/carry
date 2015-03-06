(function(win, doc, Backbone, $$MIS){
  var NewMaterialView = Backbone.View.extend({
    events: {
      'change input[name]': "set_del"
    },

    set_del: function(evt){
      var input = evt.currentTarget;
      var name = input.name.match(/\[(.*)\]/)[1];
      if(!!name){
        this.model.set(name, input.value);
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.NewMaterialView = NewMaterialView;
})(window, document, Backbone, window.$$MIS);