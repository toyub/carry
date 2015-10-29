(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['kucun/saleinfos/new/form'];
  var summary_tmpl = JST['kucun/saleinfos/new/summary'];
  var SaleinfoServiceView = Backbone.View.extend({
    tagName: 'div',
    className: 'add_server',
    events: {
      'submit form': 'commit'
    },
    summary:function() {
      var attrs = this.model.attrs();
          attrs.viewid = this.cid;
          attrs.idx = this.idx;
      return summary_tmpl(attrs);
    },
    show: function(){
      var attrs = this.model.attrs();
          attrs.viewid = this.cid;
          attrs.idx = this.idx;
      return '<div class="list_content list_tr" data-viewid="'+ this.cid + '">' +
              summary_tmpl(attrs) +
            '</div>';
    },
    render: function(){
      var attrs = this.model.attrs();
      attrs.store_commission_templates = this.store_commission_templates;
      this.$el.html(tmpl(attrs));
      this.$el.data('modelid', this.model.cid);
      this.$el.data('viewid', this.cid);
      return this;
    },
    commit: function(evt){
      evt.preventDefault();
      var target = evt.target;
      var $form = $(target);
      var saleinfo = $form.serializeJSON();
      this.model.set(saleinfo);
      if(this.model.isNew()){
        this.create();
      }else{
        this.update();
      }
      return false;
    },
    create: function(){
      this.model.set('id', 1)
      this.trigger('created');
    },
    update: function(){
      this.trigger('updated');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoServiceView = SaleinfoServiceView;
})(window, document, Backbone, window.$$MIS);
