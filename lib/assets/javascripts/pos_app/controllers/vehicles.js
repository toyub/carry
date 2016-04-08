(function(win, doc, $, $$MIS){
  var VehicleOperator = {};
  _.extend(VehicleOperator, Backbone.Events);
  var current_vehicle = new Mis.Models.StoreVehicle();
  var current_customer = new Mis.Models.StoreCustomer();

  function VehiclesController(){/*需要在此做一些初始化的工作*/
    var vehicle_search = $$MIS.getVehicleSearchInstance();
    _.extend(this, Backbone.Events);
    this.listenTo(vehicle_search, 'vehicleexist', function(vehicle_id){
      if(vehicle_id){
        current_vehicle.id = vehicle_id
        current_vehicle.fetch();
      }
    });

    this.listenTo(vehicle_search, 'chosevehicle', function(vehicle_id){
      if(vehicle_id){
        current_vehicle.id = vehicle_id
        current_vehicle.fetch();
      }
    })
    var afterVehicleFetch = function(){
      vehicle_search.afterVehicleFetch(current_vehicle.attributes.store_customer);
    }
    VehicleOperator.listenTo(current_vehicle, 'change', afterVehicleFetch);
  }

  var instance = null;
  win.$$MIS = $$MIS || {};
  win.$$MIS.getVehiclesControllerInstance = function(){
    if(!instance){
      instance = new VehiclesController();
    }
    return instance;
  }
})(window, document, jQuery, window.$$MIS);
