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
  },

  essentials: function(){
    return {
      brand_name: this.getBrandName(),
      series_name: this.getSeriesName(),
      model_name: this.getModelName()
    };
  },
  getBrandName: function(){
    if(this.attributes.vehicle_brand){
      return this.attributes.vehicle_brand.name;
    }else{
      return '';
    }
  },
  getSeriesName: function(){
    if(this.attributes.vehicle_series){
      return this.attributes.vehicle_series.name;
    }else{
      return '';
    }
  },
  getModelName: function(){
    if(this.attributes.vehicle_model){
      return this.attributes.vehicle_model.name;
    }else{
      return '';
    }
  }
})
