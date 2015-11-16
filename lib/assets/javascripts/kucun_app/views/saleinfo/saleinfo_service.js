(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['kucun/saleinfos/new/form'];
  var SaleinfoServiceView = Backbone.View.extend({
    tagName: 'div',
    className: 'add_server',
    events: {
      'submit form': 'commit',
      'click .cancel_btn': 'cancel'
    },

    cancel: function(){
      if(!this.model.commited && !this.model.get('id')){
        this.model.destroy();
      }
      this.after_close();
    },

    render: function(){
      var attrs = this.model.attrs();
      attrs.store_commission_templates = this.store_commission_templates;
      this.$el.html(tmpl(attrs));
      this.$el.data('modelid', this.model.cid);
      this.$el.data('viewid', this.cid);
      return this;
    },
    after_close: function(){
      this.undelegateEvents();
      this.stopListening();
      this.remove();
      delete this.model;
      delete this;
      $('#add_server_btn').removeClass('disabled');
    },

    commit: function(evt){
      evt.preventDefault();
      var target = evt.target;
      var $form = $(target);
      var service = $form.serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true});
      this.model.set(service);
      if(this.model.commited || !!this.model.get('id')){
        this.update();
      }else{
        this.create();
      }
      this.after_close();
      return false;
    },

    create: function(){
      this.model.commited = true;
      this.trigger('created');
    },

    update: function(){
      this.trigger('updated');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoServiceView = SaleinfoServiceView;
})(window, document, Backbone, window.$$MIS);
