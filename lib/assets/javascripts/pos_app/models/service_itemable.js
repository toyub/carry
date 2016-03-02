Mis.Models.ServiceItemable = Backbone.Model.extend({
  listPrice: function(){
    var list_price = this.get('retail_price');
    if(this.get('bargain_price_enabled') && this.get('bargain_price')){
      list_price = this.get('bargain_price');
    }
    return parseFloat(list_price || 0).toFixed(2);
  },

  orderPrice: function(customer){
    var price = this.listPrice();
    if(this.get('vip_price_enabled') && customer.membership){
      if(customer.category){
        if(customer.category.discounts && customer.category.discounts.service_root_categories){
          var root_category_discounts = customer.category.discounts.service_root_categories[this.get('category_id')];
          if(root_category_discounts){
              if(root_category_discounts.forall_enabled && root_category_discounts.forall_rate){
                price = parseFloat(root_category_discounts.forall_rate) * this.listPrice() * 0.01;
              }else{
                if(root_category_discounts.services){
                  var service_discounts = root_category_discounts.services[this.get('id')];
                  if(service_discounts && service_discounts.rate){
                    price = parseFloat(service_discounts.rate) * this.listPrice() * 0.01;
                  }
                }
              }
          }
        }
      }
    }
    return parseFloat(price || 0).toFixed(2);
  },

  toItemAttrs: function(customer){
    var price = this.orderPrice(customer);
    var _attrs = {
      name: this.get('name'),
      orderable_id: this.get('id'),
      orderable_type: 'StoreService',
      retail_price: this.listPrice(),
      price: price,
      cached_price: price,
      quantity: 1,
      discount: null,
      discount_reason: null
    };
    if(this.get('vip_price_enabled') && customer.membership){
      _attrs.vip_price = price;
    }

    return _attrs;
  },

  toListAttrs: function(){
    var _attrs = _.clone(this.attributes);
    _attrs.list_price = this.listPrice();
    return _attrs;
  }
})
