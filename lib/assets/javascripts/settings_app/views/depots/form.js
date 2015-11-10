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
    set_summary_view: function(){
      this.summary_view = new $$MIS.DepotSummaryView({model: this.model});
      return this.summary_view.render();
    },
    save: function(evt){
      evt.preventDefault();
      var target = evt.target;
      var $form = $(target)
      var attrs = $form.serializeJSON();
      this.model.set(attrs);
      this.$el.hide();
      $("#summaries").append(this.set_summary_view());
      $('input.new_btn').removeClass('disabled');
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotFormView = DepotFormView;
})(window, document, Backbone, window.$$MIS);
