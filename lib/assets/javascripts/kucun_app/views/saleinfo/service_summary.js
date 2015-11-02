(function(win, doc, Backbone, $$MIS){
  var summary_tmpl = JST['kucun/saleinfos/new/summary'];
  var showtmpl = JST['kucun/saleinfos/new/show'];
  var SaleinfoServiceSummaryView = Backbone.View.extend({
    tagName: 'div',
    className: 'list_content list_tr',
    events: {
      'click .click_btn': 'show_detail'
    },
    render: function(){
      var attrs = this.model.summary_attrs();
      attrs.idx = this.idx;
      this.$el.html(summary_tmpl(attrs));
      this.$el.data('modelid', this.model.cid);
      return this.el;
    },
    show_detail: function(){
      var attrs = this.model.detial_attrs();
      $('.server_list').append(showtmpl(attrs))
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoServiceSummaryView = SaleinfoServiceSummaryView;
})(window, document, Backbone, window.$$MIS);
