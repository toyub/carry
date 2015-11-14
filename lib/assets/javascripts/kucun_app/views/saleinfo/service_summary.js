(function(win, doc, Backbone, $$MIS){
  var summary_tmpl = JST['kucun/saleinfos/new/summary'];
  var showtmpl = JST['kucun/saleinfos/new/show'];
  var SaleinfoServiceSummaryView = Backbone.View.extend({
    tagName: 'div',
    className: 'list_content list_tr',
    events: {
      'click .click_btn': 'show_detail',
      'click .delete': 'delete'
    },
    render: function(){
      var attrs = this.model.summary_attrs();
      attrs.idx = this.idx;
      this.$el.html(summary_tmpl(attrs));
      this.$el.data('modelid', this.model.cid);
      return this.el;
    },
    set_detial_el:function(attrs){
      this.detial_el = $("<div>").addClass("add_server server_details").html(showtmpl(attrs));
      return this.detial_el;
    },
    show_detail: function(){
      if(this.detial_el){
        this.detial_el.show();
      }else{
        var _attrs = this.model.detial_attrs();
        this.set_detial_el(_attrs);
        $('.server_list').append(this.detial_el);
      }

    },

    delete: function() {
      confirm('是否要删除该项目？');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoServiceSummaryView = SaleinfoServiceSummaryView;
})(window, document, Backbone, window.$$MIS);
