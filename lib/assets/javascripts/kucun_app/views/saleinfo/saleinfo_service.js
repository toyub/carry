(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['kucun/saleinfos/new/form'];
  var summary_tmpl = JST['kucun/saleinfos/new/summary'];
  var attrs_for_reset = {};
  var SaleinfoServiceView = Backbone.View.extend({
    tagName: 'div',
    className: 'add_server',
    events: {
      'submit form': 'commit',
      'click .cancel_btn': 'cancel'
    },
    summary:function() {
      var attrs = this.model.summary_attrs();
          attrs.viewid = this.cid;
          attrs.idx = this.idx;
      return summary_tmpl(attrs);
    },
    cancel: function(){
      alert("TODO: fix this")
      if(this.model.commited || !!this.model.get('id')){

      }else{

      }
    },
    show: function(){
      var attrs = this.model.summary_attrs();
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
      var service = $form.serializeJSON();
      this.model.set(service);
      attrs_for_reset = this.model.attributes;
      if(this.model.commited || !!this.model.get('id')){
        this.update();
      }else{
        this.create();
      }
      return false;
    },
    create: function(){
      $('#lists').append(this.show());
      $('div.list').show();
      this.$el.hide();
      $('#add_server_btn').removeClass('disabled');
      this.summary_el = $('#lists').find("div[data-viewid='"+ this.cid +"']");
      this.model.commited = true;
      this.trigger('created');
    },
    update: function(){
      this.summary_el.html(this.summary())
      this.$el.hide();
      $('#add_server_btn').removeClass('disabled');
      this.trigger('updated');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoServiceView = SaleinfoServiceView;
})(window, document, Backbone, window.$$MIS);
