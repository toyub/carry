Mis.Models.StoreCustomer = Backbone.Model.extend({
  urlRoot: "/api/crm/customers",
  url: function(){
    if(this.id){
      return "/api/crm/customers/" + this.id;
    }else{
      return this.constructor.__super__.url.call(this);
    }
  },

  pull: function(){
    var _this = this;
    return this.fetch({
      success: function(){
        _this.trigger('updated');
      }
    });
  },
  essentials: function(){
    return {
      property_i18n: this.attributes.property_i18n,
      category_name: this.attributes.category_name,
      payment_mode_i18n: this.attributes.payment_mode_i18n,
    };
  }
})
