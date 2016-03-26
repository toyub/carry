Mis.Models.StoreVehicle = Backbone.Model.extend({
  urlRoot: "/api/store_vehicles",
  url: function(){
  	if(this.id){
  	  return "/api/store_vehicles/" + this.id;
  	}else{
      return this.constructor.__super__.url.call(this);
  	}
  }
})
