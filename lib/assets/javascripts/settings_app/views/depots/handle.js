(function(win, doc, Backbone, $$MIS){
  views = {};
  var DepotsHandleView = Backbone.View.extend({
    el: 'body',
    events: {
      'click .new_btn': 'add'
    },
    add: function(evt){
      var target = evt.target;
      if(target.classList.contains('disabled')){
        return false;
      }
      target.classList.add('disabled');
      var model = new $$MIS.Depot();
      var form_view = new $$MIS.DepotFormView({model: model});
      this.$el.append(form_view.render());
      views[form_view.cid] = form_view;
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotsHandleView = DepotsHandleView;
})(window, document, Backbone, window.$$MIS);
