(function(win, doc, $, $$MIS){
  var VehicleOperator = {};
  _.extend(VehicleOperator, Backbone.Events);
  var current_vehicle = new Mis.Models.StoreVehicle();
  var current_customer = new Mis.Models.StoreCustomer();

  var handle = {
    createVehicleSuccess: function(){
      console.log(arguments);
    }
  }

  function editVehicle(){
    if(current_vehicle.isNew()){
      showAddVehicleForm();
    }else{
      Mis.Views.editVehicle(current_vehicle.attributes);
    }
  }

  function editCustomer(){
    if(current_customer.isNew()){
      showAddVehicleForm();
    }else{
      Mis.Views.editCustomer(current_vehicle.attributes);
    }
  }

  function showAddVehicleForm(){
    new Mis.Views.NewCustomerView({customer: null, license_number: ''}, handle);
  }

  function resetVehicle(vehicle){
    if(!vehicle){
      current_vehicle = new Mis.Models.StoreVehicle();
      current_customer = new Mis.Models.StoreCustomer();
      instance.trigger('vehiclechange', current_vehicle, current_customer);
    }
  }

  function resetCustomer(customer_id){

  }

  function choseVehicle(vehicle_id){
    if(vehicle_id){
      current_vehicle.id = vehicle_id
      current_vehicle.fetch();
    }
  }

  function vehicleExist(vehicle_id){
    if(vehicle_id){
      current_vehicle.id = vehicle_id
      current_vehicle.fetch();
    }
  }


  function VehiclesController(){/*需要在此做一些初始化的工作*/
    var vehicle_search = $$MIS.getVehicleSearchInstance();
    _.extend(this, Backbone.Events);

    this.listenTo(vehicle_search, 'vehicleexist', vehicleExist);
    this.listenTo(vehicle_search, 'chosevehicle', choseVehicle);
    this.listenTo(vehicle_search, 'resetvehicle', resetVehicle);
    this.listenTo(vehicle_search, 'resetcustomer', resetCustomer);
    var _this = this;
    VehicleOperator.listenTo(current_vehicle, 'change', function(){
      current_customer.set(current_vehicle.attributes.store_customer)
      vehicle_search.afterVehicleFetch(current_vehicle.attributes.store_customer);
      _this.trigger('vehiclechange', current_vehicle, current_customer);
    });

    this.editCustomer = editCustomer;
    this.editVehicle = editVehicle;
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
