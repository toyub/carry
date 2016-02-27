Mis.Models.MaterialItemable = Backbone.Model.extend({
  getPrice: function(customer){
    console.log(customer)
    return this.get('retail_price')
  }
})
