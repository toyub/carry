Mis.Models.ServiceItemable = Backbone.Model.extend({
  getPrice: function(customer){
    var price = this.get('retail_price');
    if(this.get('bargain_price_enabled')){
      if(customer.membership){
        price = this.get('bargain_price');
      }
    }
    return parseFloat(price || 0);
  },

  getVipPrice: function(){
    if(this.get('bargain_price_enabled')){
      return this.get('bargain_price');
    }
  },

  toItemAttrs: function(customer){
    var price = this.getPrice(customer);
    var vip_price = this.getVipPrice();
    var _attrs = {
      name: this.get('name'),
      orderable_id: this.get('id'),
      orderable_type: 'StoreService',
      retail_price: this.get('retail_price'),
      price: price,
      cached_price: price,
      quantity: 1,
      discount: null,
      discount_reason: null
    };
    if(vip_price && customer.membership){
      _attrs.vip_price = vip_price;
    }

    return _attrs;
  }
})
