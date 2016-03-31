(function(win, doc, Backbone, $$MIS){
  var Order = Backbone.Model.extend({
    
    queuing: function(){
      return this.get('pay_status') == 'pay_queuing';
    },
    finished: function(){
      return this.get('pay_status') == 'pay_finished' || this.get('pay_status') == 'pay_hanging';
    },

    pay_pending: function(){
      return !this.checked();
    },

    checked: function(){
      return this.get('pay_status') == 'pay_finished' || this.get('pay_status') == 'pay_hanging';
    },

    attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.can_pay = this.pay_pending();
      return _attrs;
    },

    pay: function(payments, callback){
      var _this = this;
      this.fetch({
          success: function(){
            if(_this.hasChanged('amount')){
              ZhanchuangAlert('请注意：订单有新的变化，请再次核对金额。');
            }else{
              var data = JSON.stringify({order_id: _this.get('id'), payments: payments});

              $.ajax({
                      type: "POST",
                      url: '/api/store_checkouts',
                      contentType: 'application/json; charset=UTF-8',
                      data: data,
                      success: function(response, status_sting, xhr){
                        if(response.checked){
                          _this.set('pay_status', 'pay_finished')
                          callback.call(_this, response);
                        }else{
                          ZhanchuangAlert('付款失败, 请检查订单状态!');
                        }

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
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Order = Order;
})(window, document, Backbone, window.$$MIS);
