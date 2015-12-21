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

      if(this.model.finished()){
        this.$el.hide();
      }
    },
    
    checkout: function(evt){
      evt.preventDefault();
      var paid_amount = this.payments.map(function(model){ return model.get('value');}).reduce(function(x,y){return x+y});
      var _this = this;
      if(this.model.get('amount') == paid_amount){
        this.model.fetch({
          success: function(){
            if(_this.model.hasChanged()){
              ZhanchuangAlert('请注意：订单有新的变化，请再次核对金额。');
            }else{
              var data = JSON.stringify({order_id: _this.model.get('id'), payments: _this.payments.toJSON()});
              $.ajax({
                      type: "POST",
                      url: '/api/store_checkouts',
                      contentType: 'application/json; charset=UTF-8',
                      data: data,
                      success: function(response, status_sting, xhr){
                        _this.trigger('checked', response);
                      },
                      error: function(){
                        ZhanchuangAlert('哎呀，您的网络好像有问题，请重试!');
                      }
                    });
            }
          },
          error: function(){
            ZhanchuangAlert('哎呀，网络好像出了问题，请重试一下');
          }
        });
      }else{
        ZhanchuangAlert('收款金额与应收不符，请检查！');
      }
    },
    combine_payment: function(){
      var ids = this.payments.map(function(m){
          return m.get('payment_method_id');
        });
      if(this.payments.length < 2){

        this.payments.add({excepts: ids});
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
