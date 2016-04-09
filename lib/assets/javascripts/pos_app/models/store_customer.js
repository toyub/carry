Mis.Models.StoreCustomer = Backbone.Model.extend({
  urlRoot: "/api/crm/customers",
  url: function(){
    if(this.id){
      return "/api/crm/customers/" + this.id;
    }else{
      return this.constructor.__super__.url.call(this);
    }
  }
})
