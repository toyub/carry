(function(win, doc, Backbone, $$MIS){
  var summary_tmpl = JST['kucun/saleinfos/new/summary'];
  var showtmpl = JST['kucun/saleinfos/new/show'];
  var SaleinfoServiceSummaryView = Backbone.View.extend({
    initialize: function(){
      this.listenTo(this.model, 'change', this.render);
    },
    tagName: 'div',
    className: 'list_content list_tr',
    events: {
      'click .delete': 'delete',
      'click .do_edit': 'edit'
    },
    render: function(){
      var attrs = this.model.summary_attrs();
      attrs.idx = this.idx;
      this.$el.html(summary_tmpl(attrs));
      this.$el.data('modelid', this.model.cid);
      return this.el;
    },

    delete: function(evt) {
      if(confirm('确定要删除此项目？')){
        var _this = this;
        this.model.destroy({
          success:function(){
            _this.remove();
          },
          error: function(){
            ZhanchuangAlert('删除失败，请重试!');
          }
        })
      }
    },

    edit: function(){
      this.trigger('edit');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoServiceSummaryView = SaleinfoServiceSummaryView;
})(window, document, Backbone, window.$$MIS);
