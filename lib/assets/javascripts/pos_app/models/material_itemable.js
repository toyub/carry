Mis.Models.MaterialItemable = Backbone.Model.extend({
  getPrice: function(customer){
    var retail_price = this.get('retail_price');
    var vip_price = this.get('vip_price');
    var
    if(customer.category){
      if(customer.category.discounts && customer.category.discounts.material_root_categories)
        var category_discounts = customer.category.discounts.material_root_categories[this.get('store_material_root_category_id')];

        if(category_discounts){
          if(category_discounts.forall_enabled){

          }else{
            if(category_discounts.sub_categories){
              var sub_category_discount = category_discounts.sub_categories[this.get('store_material_category_id')];
              if(sub_category_discount){

              }
            }
          }
        }
    }


    var price = this.get('retail_price');
    if(this.get('vip_price_enabled')){
      if(customer.membership){
        price = this.get('vip_price');
      }
    }
    return parseFloat(price || 0);
  }
})
