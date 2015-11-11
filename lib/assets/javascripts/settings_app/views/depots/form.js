(function(win, doc, Backbone, $$MIS){
  var template = JST['settings/depots/new/form'];
  var DepotFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'new_warehouse_wrap',
    events: {
      'submit form': 'save'
    },
    render: function(){
      this.$el.html(template(this.model.attributes));
      return this.$el;
    },
    save: function(evt){
      evt.preventDefault();
      this.model.set($(evt.target).serializeJSON());
      if(this.model.commited || this.model.get('id')){
        this.update();
      }else{
        this.create();
      }
    },
    create: function(){
      this.model.commited = true;
      this.model.save();
      this.trigger('created');
    },
    update: function(){
      this.trigger('updated');
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotFormView = DepotFormView;
})(window, document, Backbone, window.$$MIS);
