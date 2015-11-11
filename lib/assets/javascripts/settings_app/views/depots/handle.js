(function(win, doc, Backbone, $$MIS){
  var DepotsHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.urlRoot = opt.urlRoot;
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
      target.classList.add('disabled');
      var controller = new $$MIS.DepotsController();
      controller.add(this);
    },
    load: function(){
      var _this = this;
      this.depots.url = this.urlRoot + '/fetch';
      this.depots.fetch().success(function(){
        _this.depots.each(function(model){
          console.log(model)
        });
      })
      .error(function(){

      })
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotsHandleView = DepotsHandleView;
})(window, document, Backbone, window.$$MIS);
