Mis.Models.MaterialItemable = Backbone.Model.extend({
  getPrice: function(customer){
    //
    // if(customer.category){
    //     customer.category.discounts.service_root_categories[this.get]
    // }
    

    var price = this.get('retail_price');
    if(this.get('vip_price_enabled')){
      if(customer.membership){
        price = this.get('vip_price');
      }
    }
    return parseFloat(price || 0);
  }
})
