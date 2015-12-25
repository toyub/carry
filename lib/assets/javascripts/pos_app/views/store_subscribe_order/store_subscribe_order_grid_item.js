Mis.Views.SubscribeOrderGridItem = Backbone.View.extend({
  tagName: "tr",
  events: {
    "click .delete_committed_btn": "clear",
    "click .lnr-edit": "show",
    "click .lnr-file-empty": "transition",
  },
  template: JST["pos/subscribe_order/table_item"],
  initialize: function(){
    this.listenTo(this.model, 'destroy', this.remove);
    this.listenTo(this.model, 'change', this.render);
  },
  render: function(){
    var el = this.template(this.model.attributes);
    this.$el.html(el);
    return this;
  },
  clear: function(){
    var _this = this;
    $.confirm({
      text: "是否确定删除？",
      confirm: function(){
        _this.model.destroy();
      }
    })
  },
  show: function(){
    $(".window_wrap").show();
  },
  transition: function(){
    var _this = this;
    window.mouse = _this.model;
    $.confirm({
      text: "是否确定预约单转为正式单？",
      confirm: function(){
        _this.model.save({state: 2}, {patch: true});
        _this.model.set({state: "已执行" });
      }
    })
  }
})
