(function(win){
  var VehicleSituation = {
    el: '#order-situation',
    data: {
      fuel_gauge: 0,
      mileage: 0,
      damages:[]
    },
    methods: {
      achecked: function(part_id){
        return this.damages.includes(part_id);
      }
    }
    
  };

  win.Mis.Vues.VehicleSituation = VehicleSituation;
})(window);
