(function(win, doc, $, $$MIS){

  function DepotsController(){

  }

  DepotsController.prototype = {
    constructor: DepotsController,
    add: function(handle){
      var _this = this;
      this.model = new $$MIS.Depot();
      model.urlRoot = handle.urlRoot;
      this.form_view = new $$MIS.DepotFormView({model: this.model, staff: handle.staff});
      
      handle.$el.append(this.form_view.render());

      this.form_view.$el.find('select.admin_ids').select2();

      this.form_view.on('created', function(){
        handle.depots.add(_this.form_view.model);
        _this.show_summary();
      });

      this.form_view.on('updated', function(){
        _this.refresh_summary();
      });

    },

    show: function(model, handle){
      var _this = this;
      this.summary_view = new $$MIS.DepotSummaryView({model: model});
      this.summary_view.on('edit', function(){
        _this.edit();
      });

      $("#summaries").append(this.summary_view.render());
    },

    show_summary: function(){
      var _this = this;
      this.summary_view = new $$MIS.DepotSummaryView({model: this.model});
      this.summary_view.on('edit', function(){
        _this.edit();
      });

      $("#summaries").append(this.summary_view.render());
      this.form_view.$el.hide();
      $('input.new_btn').removeClass('disabled');
    },

    refresh_summary: function(){
      this.form_view.$el.hide();
      $('input.new_btn').removeClass('disabled');
    },

    edit: function(a,b,c,d){
      $('input.new_btn').addClass('disabled');
      if(this.form_view){
        this.form_view.$el.show();
      }else{
        
      }
    }
  };

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotsController = DepotsController;
})(window, document, jQuery, window.$$MIS);
