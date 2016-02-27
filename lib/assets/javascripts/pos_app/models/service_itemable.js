Mis.Models.ServiceItemable = Backbone.Model.extend({
  getPrice: function(customer){
    var price = this.get('retail_price');
    if(this.get('bargain_price_enabled')){
      if(customer.membership){
        price = this.get('bargain_price');
      }
    }
    return parseFloat(price || 0);
  }
})
