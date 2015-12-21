(function(win, doc, Backbone, $$MIS){
  var Methods = [
                          {id: 0, name: '现金'},
                          {id: 1, name: '银行卡'},
                          {id: 2, name: '支付宝'},
                          {id: 3, name: '微信'},
                          {id: 4, name: '储值余额'},
                          {id: 5, name: '挂账'}
                        ];
  var PaymentMethods={
    except: function(id){
      return Methods.filter(function(m){return m.id != id});
    },
    excepts: function(ids){
      console.log(ids)
      return Methods.filter(function(m){return m.id != ids});
    }
  }                  
  
  win.$$MIS.PaymentMethods = PaymentMethods;
})(window, document, Backbone, window.$$MIS);
