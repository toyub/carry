(function(win, doc, $, $$MIS){

  function DepotsController(model, handle){
    if(!model){
      this.model = new $$MIS.Depot();
    }else {
      this.model = model;
    }
    this.handle = handle;
    this.model.urlRoot = this.handle.urlRoot;
  }

  DepotsController.prototype = {
    constructor: DepotsController,
    before_edit: function(){
      $('input.new_btn').addClass('disabled');
    },

    after_save: function(){
      this.form_view.$el.hide();
      $('input.new_btn').removeClass('disabled');
    },

    set_form_view: function(){
      var _this = this;
      this.form_view = new $$MIS.DepotFormView({model: this.model, staff: this.handle.staff});

      this.handle.$el.append(this.form_view.render());
      this.form_view.$el.find('select.admin_ids').select2();
      this.form_view.on('created', function(){
        _this.handle.depots.add(_this.form_view.model);
        _this.show();
        _this.after_save();
      });

      this.form_view.on('updated', function(){
        _this.after_save();
      });

      this.form_view.on('deleted', function(){
        _this.destroy();
      })
    },

    set_summary_view: function(){
      var _this = this;
      this.summary_view = new $$MIS.DepotSummaryView({model: this.model, staff: this.handle.staff});
      $("#summaries").append(this.summary_view.render());
      this.summary_view.on('edit', function(){
        _this.edit();
      });
      this.summary_view.on('deleted', function(){
        _this.destroy();
      })
    },

    add: function(){
      this.before_edit();
      this.set_form_view();
    },

    show: function(){
      this.set_summary_view();
    },

    edit: function(){
      this.before_edit();
      if(this.form_view){
        this.form_view.$el.show();
      }else{
        this.set_form_view();
      }
    },

    destroy: function(){
      if(this.summary_view){
        this.summary_view.stopListening()
        this.summary_view.remove();
        delete this.summary_view.model;
        delete this.summary_view;
      }

      if(this.form_view){
        this.form_view.stopListening();
        this.form_view.remove();
        delete this.form_view.model;
        delete this.form_view;
      }

      this.handle = null;
      delete this;

      $('#summaries').children()
                     .each(function(idx, tr){
                        tr.children[0].innerHTML = (tr.rowIndex-1);
                      });
    }
  };

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotsController = DepotsController;
})(window, document, jQuery, window.$$MIS);
