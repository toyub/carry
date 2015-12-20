(function(win, doc, Backbone, $$MIS){
  var order_tmpl = JST["pos/cashier/checkouts/order"];
  var CashierOrderDetailView = Backbone.View.extend({
    tagName: 'div',
    className: 'float-left order-detail',
    events: {
      'submit form': 'checkout',
      'click .add_method': 'combine_payment',
      'change .js-invoice-required': 'toggle_invoice'
    },
    initialize: function(){
      this.listenTo(this.model, 'change', this.rerender)
      this.payments = new $$MIS.PaymentCollection();
      this.listenTo(this.payments, 'add', this.add_payment)
    },
    render: function(){
      var _attrs = this.model.attributes;
      _attrs.can_add = this.payments.length < 2;
      this.$el.html(order_tmpl(_attrs));
      $('.cashiering').append(this.$el)
      this.payments.add({})
    },
    rerender: function(){
      var _attrs = this.model.attributes;
      _attrs.can_add = this.payments.length < 2;
      this.$el.html(order_tmpl(_attrs));
      var _this = this;
      this.payments.each(function(model, idx, arr, undef){
        var payment_view = new $$MIS.PaymentView({model: model})
        _this.$el.find('.payment_method').append(payment_view.render());  
      });
    },
    checkout: function(evt){
      console.log(this)
      evt.preventDefault();
      this.model.fetch();
      var paid_amount = this.payments.map(function(model){ return model.get('value');}).reduce(function(x,y){return x+y});
      if(this.model.get('amount')==paid_amount){

      }else{
        alert([this.model.get('amount'), paid_amount].join(', '))
      }
    },
    combine_payment: function(){
      if(this.payments.length < 2){
        this.payments.add({});
      }
      if(this.payments.length >= 2){
        this.$el.find('.add_method').hide();
        this.$el.find('.js-tip').show();
      }

    },
    add_payment: function(model, collection, options, undef){
      console.log(this.$el.find('.payment_method'))
      var payment_view = new $$MIS.PaymentView({model: model})
      this.$el.find('.payment_method').append(payment_view.render());
    },
    toggle_invoice: function(){
      this.model.set('invoice_required', !this.model.get('invoice_required'));
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierOrderDetailView = CashierOrderDetailView;
})(window, document, Backbone, window.$$MIS);
