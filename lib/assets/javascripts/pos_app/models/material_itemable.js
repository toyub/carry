Mis.Models.MaterialItemable = Backbone.Model.extend({
  listPrice: function(){
    var list_price = this.get('retail_price');
    if(this.get('bargainable') && this.get('bargain_price')){
      list_price = this.get('bargain_price');
    }
    return parseFloat(list_price || 0).toFixed(2);
  },

  orderPrice: function(customer){
    var price = this.listPrice();
    if(this.get('vip_price_enabled') && customer.membership){
      if(customer.category){
        if(customer.category.discounts && customer.category.discounts.material_root_categories){
          var root_category_discounts = customer.category.discounts.material_root_categories[this.get('store_material_root_category_id')];
          if(root_category_discounts){
              if(root_category_discounts.forall_enabled && root_category_discounts.forall_rate){
                price = parseFloat(root_category_discounts.forall_rate) * this.listPrice() * 0.01;
              }else{
                if(root_category_discounts.sub_categories){
                  var category_discounts = root_category_discounts.sub_categories[this.get('store_material_category_id')];
                  if(category_discounts && category_discounts.rate){
                    price = parseFloat(category_discounts.rate) * this.listPrice() * 0.01;
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
      speci: this.get('speci'),
      orderable_type: 'StoreMaterialSaleinfo',
      orderable_id: this.get('id'),
      retail_price: this.listPrice(),
      price: price,
      cached_price: price,
      cost_price: this.get('cost_price'),
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
