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
      this.listenTo(this.payments, 'add', this.add_payment);
    },

    render: function(){
      var _attrs = this.model.attributes;
      _attrs.can_add = this.payments.length < 2;
      this.$el.html(order_tmpl(_attrs));
      $('.cashiering').append(this.$el);
      this.combine_payment();
    },

    rerender: function(){
      var _attrs = this.model.attributes;
      _attrs.can_add = this.payments.length < 2;
      this.$el.html(order_tmpl(_attrs));
      var _this = this;
      this.payments.authorized_payments().forEach(function(model){
        model.set('paid', !_this.model.pay_pending());
        var payment_view = new $$MIS.PaymentView({model: model})
        _this.$el.find('.payment_method').append(payment_view.render());
      });
    },

    checkout: function(evt){
      evt.preventDefault();
      var paid_amount = this.payments.combined_amount();
      var _this = this;
      if(this.model.get('amount') == paid_amount){
        this.model.pay(this.payments.as_json(), function(response){
          _this.trigger('checked', response);
        });
      }else{
        ZhanchuangAlert('收款金额与应收不符，请检查！');
      }
    },

    combine_payment: function(){
      if(!this.model.pay_pending()){
        return;
      }
      if(this.payments.length < 2){
        this.payments.combine();
      }
      if(this.payments.length >= 2){
        this.$el.find('.add_method').hide();
        this.$el.find('.js-tip').show();
      }
    },

    add_payment: function(model, collection, options, undef){
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
