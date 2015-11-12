(function(win, doc, Backbone, $$MIS){
  var template = JST['settings/depots/new/form'];
  var DepotFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'new_warehouse_wrap',
    events: {
      'submit form': 'save',
      'click .cancel_btn': 'cancel'
    },
    initialize: function(opt){
      this.model = opt.model;
      this.staff = opt.staff;
    },
    render: function(){
      var _attrs = _.clone(this.model.attributes);
      _attrs.staff = this.staff;
      this.$el.html(template(_attrs));
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
      this.model.save();
      this.trigger('updated');
    },

    cancel: function(){
      if(this.model.commited || this.model.get('id')){
        this.render();
        this.$el.find('select.admin_ids').select2();
        this.$el.hide();
      }else{
        this.trigger('deleted');
      }
      $('input.new_btn').removeClass('disabled');
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotFormView = DepotFormView;
})(window, document, Backbone, window.$$MIS);
