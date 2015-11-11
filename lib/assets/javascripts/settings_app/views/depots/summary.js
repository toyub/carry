(function(win, doc, Backbone, $$MIS){
  var summary_tmpl = JST['settings/depots/new/summary'];
  var DepotSummaryView = Backbone.View.extend({
    tagName: 'tr',
    events: {
      'click .edit_warehouse': 'edit',
      'click .useable': 'toggle_useable',
      'click .preferred': 'prefer'
    },
    initialize: function(){
      this.listenTo(this.model, "change", this.refresh);
    },
    render: function(){
      this.$el.html(summary_tmpl(this.model.summary_attrs()));
      return this.$el;
    },

    edit: function(){
      this.trigger('edit');
    },

    refresh: function(){
      this.$el.html(summary_tmpl(this.model.summary_attrs()));
    },
    toggle_useable: function(){
      if(this.model.get('useable') && this.model.get('preferred')){
        ZhanchuangAlert('不能停用默认仓库，请先设置其他仓库为默认仓库后再停用！');
        return false;
      }
      if(this.model.get('useable')){
        var _this = this;
        $.get(this.model.url() + "/binding_material_count").success(function(data){
          if(data.bound > 0){
            $('#bound_count').html(data.bound);
            $('#transfer_link').attr('href', "/kucun/transfer/pickings/new?depot_id=" + _this.model.get('id'));
            $('#bound_alert').show();
          }else{
            _this.model.set('useable', false);
          }
        })
        .error(function(){
          ZhanchuangAlert("系统错误，请重试!");
        })
      }else{
        this.model.set('useable', true);
      }
    },

    prefer: function(){
      if(!this.model.get('useable')){
        ZhanchuangAlert('不能将已经停止使用的仓库设置为默认仓库！');
        return false;
      }
      var current_default = this.model.collection.current_default();
      if(current_default){
        current_default.set('preferred', false);
      }
      this.model.set('preferred', true);
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotSummaryView = DepotSummaryView;
})(window, document, Backbone, window.$$MIS);
