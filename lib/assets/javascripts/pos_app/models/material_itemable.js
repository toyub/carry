Mis.Models.MaterialItemable = Backbone.Model.extend({
  getPrice: function(customer){
    var price = this.get('retail_price');
    if(this.get('vip_price_enabled')){
      if(customer.membership){
        price = this.get('vip_price');
      }
    }
    return parseFloat(price || 0);
  },

  getVipPrice: function(){
    if(this.get('vip_price_enabled')){
      return this.get('vip_price');
    }
  },

  toItemAttrs: function(customer){
    var price = this.getPrice(customer);
    var vip_price = this.getVipPrice();
    var _attrs = {
      name: this.get('name'),
      speci: this.get('speci'),
      orderable_type: 'StoreMaterialSaleinfo',
      orderable_id: this.get('id'),
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
