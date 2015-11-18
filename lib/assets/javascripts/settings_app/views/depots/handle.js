(function(win, doc, Backbone, $$MIS){
  var DepotsHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.urlRoot = opt.urlRoot;
      this.staff = opt.staff;
      this.depots = new $$MIS.DepotCollection();
      this.load();
    },
    events: {
      'click .new_btn': 'add'
    },
    add: function(evt){
      var target = evt.target;
      if(target.classList.contains('disabled')){
        return false;
      }
      var controller = new $$MIS.DepotsController(null, this);
      controller.add();
    },
    load: function(){
      var _this = this;
      this.depots.url = this.urlRoot + '/fetch';
      this.depots.fetch().success(function(){
        _this.depots.each(function(model){
          var controller = new $$MIS.DepotsController(model, _this);
          controller.show();
        });
      })
      .error(function(){
        
      })
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotsHandleView = DepotsHandleView;
})(window, document, Backbone, window.$$MIS);
