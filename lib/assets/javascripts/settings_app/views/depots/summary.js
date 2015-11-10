(function(win, doc, Backbone, $$MIS){
  var summary_tmpl = JST['settings/depots/new/summary'];
  var DepotSummaryView = Backbone.View.extend({
    tagName: 'tr',
    render: function(){
      this.$el.html(summary_tmpl(this.model.summary_attrs()));
      return this.$el;
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotSummaryView = DepotSummaryView;
})(window, document, Backbone, window.$$MIS);
