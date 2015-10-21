Mis.Views.SubscribeOrderGridItem = Backbone.View.extend({
  tagName: "tr",
  events: {
    "click .delete_committed_btn": "clear"
  },
  template: JST["xianchang/subscribe_order/table_item"],
  initialize: function(){
    this.listenTo(this.model, 'destroy', this.remove);
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
  }
})
