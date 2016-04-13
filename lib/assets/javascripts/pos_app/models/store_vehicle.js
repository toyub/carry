Mis.Models.StoreVehicle = Backbone.Model.extend({
  urlRoot: "/api/store_vehicles",
  url: function(){
  	if(this.id){
  	  return "/api/store_vehicles/" + this.id;
  	}else{
      return this.constructor.__super__.url.call(this);
  	}
  },

  isMembership: function(){
    if(!this.id){
      return false;
    }else{
      return false;
    }
  },

  pull: function(){
    var _this = this;
    return this.fetch({
      success: function(){
        _this.trigger('updated');
      }
    });
  }
})
