(function(win, doc, Backbone, $$MIS){
  var order_tmpl = JST["pos/cashier/checkouts/order"];
  var CashierOrderDetailView = Backbone.View.extend({
    tagName: 'div',
    className: 'float-left order-detail',
    events: {
      'submit form': 'checkout',
      'click .add_method': 'combine_payment',
      'change select[name=payment_method]': 'deposit_monitor',
      'click .js-send-code': 'send_authentication_code',
      'click .js-xiaopiao': 'print_receipt'
    },

    initialize: function(){
      this.listenTo(this.model, 'change', this.rerender)
      this.payments = new $$MIS.PaymentCollection();
      this.listenTo(this.payments, 'add', this.add_payment);
    },

    render: function(){
      var _attrs = this.model.attrs();
      _attrs.can_add = this.payments.length < 2;
      this.$el.html(order_tmpl(_attrs));
      $('.cashiering').append(this.$el);
      if(this.model.checked()){
        this.payments.add(this.model.attributes.payments);
      }else{
        this.combine_payment();
      }
    },

    rerender: function(){
      var _attrs = this.model.attrs();
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
        if(this.payments.contains_deposit()){
          var authentication_code = this.$el.find('input[name=authentication_code]').val();
          if(!authentication_code){
            ZhanchuangAlert('请输入验证码');
            return false;
          }
          this.pay_with_deposit(authentication_code);
        }else{
          this.commit();
        }
      }else{
        ZhanchuangAlert('收款金额与应收不符，请检查！');
      }
    },

    commit: function(){
      var _this = this;
      this.model.pay(this.payments.as_json(), function(response){
        _this.trigger('checked', response);
      });
    },

    deposit_monitor: function(evt){
      var target = evt;
      if(target.value == 'PaymentMethods::Deposit'){
        this.use_deposit = true;
      }else{
        var selected_paymentd_methods = this.$el.find('select[name=payment_method]').map(function(sx,si){return si.value}).toArray();
        if(selected_paymentd_methods.every(function(name){
          return name != 'PaymentMethods::Deposit';
        })){
          this.$el.find('.js-authentication').hide();
        }else{
          this.$el.find('.js-authentication').show();
        }
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

    add_hang: function(){
      this.$el.find('.add_method').hide();
      this.$el.find('.js-tip').hide();
      this.$el.find('.js-authentication').hide();
      this.payments.add({
        payment_method: PaymentMethods.get_by_name('PaymentMethods::Internalcredit'),
        payment_methods: PaymentMethods.available_methods(),
        amount: this.model.get('amount')
      });
      if(this.model.get('store_customer').account.credit_line < 0){
        ZhanchuangAlert('注意： 该用户的挂账额度已经透支，请谨慎操作！');
      }
    },

    remove_hang: function(){
      this.$el.find('.add_method').show();
      this.combine_payment();
    },

    add_payment: function(model, collection, options, undef){
      var _this = this;
      if(this.model.checked()){
        model.set('paid', true);
      }
      model.set('credit_able', this.model.get('store_customer').account.credit_able);
      var payment_view = new $$MIS.PaymentView({model: model});
      payment_view.on('hang!', function(){
        this.model.destroy()
        _this.payments.each(function(model){
          model.destroy();
        });
        _this.add_hang();
      });

      payment_view.on('not:hang!', function(){
        this.model.destroy();
        _this.remove_hang();
      });
      this.$el.find('.payment_method').append(payment_view.render());
    },

    send_authentication_code: function(){
      var customer = this.model.get('store_customer');
      var data = {
        customer_id: customer.id
      };
      $.ajax({
        type: 'POST',
        url: '/ajax/sms_captchas',
        data: data,
        success: function(response){
          ZhanchuangAlert('消费验证码已经发送到手机号码为'+ customer.phone_number + '的客户。');
        },
        error: function(){
          ZhanchuangAlert("网络超时，请重试!");
        }
      });
    },
    pay_with_deposit: function(authentication_code){
      var _this = this;
      var customer = this.model.get('store_customer');
      var data = {
        customer_id: customer.id,
        authentication_code: authentication_code
      };
      $.ajax({
        type: 'POST',
        url: '/ajax/sms_captchas/validate',
        data: data,
        success: function(response){
          if(response && response.valid){
            _this.real_pay_deposit(authentication_code);
          }else{
            ZhanchuangAlert("验证码错误！");
          }
        },
        error: function(){
          ZhanchuangAlert("网络超时，请重试!");
        }
      });
    },
    real_pay_deposit:function(authentication_code){
      var _this = this;
      var customer = this.model.get('store_customer');
      var amount = this.payments.deposit_pay_amount();
      var data = {
        authentication_code: authentication_code,
        amount: amount,
        order_id: this.model.get('id')
      }
      $.ajax({
        type: 'POST',
        url: '/api/store_customer_accounts/'+customer.id  +'/expense',
        data: data,
        success:function(response){
          if(response){
            if(response.valid && response.paid){
              _this.commit();
            }else{
              ZhanchuangAlert(response.msg);
            }
          }else{
            ZhanchuangAlert("储值帐号扣款失败！")
          }
        },
        error:function(){
          ZhanchuangAlert("网络错误，请重试！");
        }
      });
    },
    print_receipt: function(){
      win.open('/receipt/pos/orders/'+this.model.get('id'), '打印小票', 'height=600,width=260,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierOrderDetailView = CashierOrderDetailView;
})(window, document, Backbone, window.$$MIS);
