Mis.Models.ServiceItemable = Backbone.Model.extend({
  getPrice: function(customer){
    console.log(this, customer)
    return this.get('retail_price')
  }
})
