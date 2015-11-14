Mis.Views.SubscribeOrderForm = Backbone.View.extend({
  el: ".window_wrap",
  template: JST["xianchang/subscribe_order/form"],
  events: {
    "click .construction_status .save_btn": "commit",
  },
  initialize: function(){
    this.render()
  },
  render: function(){
    this.$el.html(this.template());
    this.initDatetimePicker();
    return this.$el;
  },
  commit: function(evt){
    evt.preventDefault();
  },
  initDatetimePicker: function(){
    $(".datetimepicker").datetimepicker({
      lang: "zh",
      format: 'Y-m-d H:i',
    });
  }
})
