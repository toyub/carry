(function(win, doc, $, $$MIS){
  var vehicle_summary_tmpl = JST['pos/orders/vehicle/summary'];
  var vehicle_essentials_tmpl = JST['pos/orders/vehicle_essentials'];
  var newCustomerFormhandle = {
    createVehicleSuccess: function(response){
      vehicleExist(response.store_vehicle_id);
    }
  }

  var vehicleAndCustomerHandler = {
    current_vehicle: new Mis.Models.StoreVehicle(),
    current_customer: new Mis.Models.StoreCustomer(),
    isOrdering: false,
    resetVehicle: function(){
      this.current_vehicle = new Mis.Models.StoreVehicle();
    },
    resetCustomer: function(){
      this.current_customer = new Mis.Models.StoreCustomer();
    },
    shwoVehicleEssentials: function(){
      var html = vehicle_essentials_tmpl({vehicle: this.current_vehicle.attributes, customer: this.current_customer.attributes});
      $('#vehicle-essentials').html(html);
    }
  }

  var getVehiclesByPhone = function(phone_number){
    $.get('/api/crm/customers/check', {phone_number: phone_number}, function(response, status_str, xhr, undef){
      if(response.success){
        var vehicles = response.customer.store_vehicles;
        var html = vehicles.map(function(vehicle){
          return '<p>' + vehicle_summary_tmpl(vehicle) + '</p>';
        });
        $('.js-customer-name').text(response.customer.full_name);
        $('#existing-vehicles div.vehicles').html(html);
        show_frequenter();
        hide_customer_tip();
        $('#existing-vehicles').show();
      }else{
        phoneNotExists();
      }
    });
  }

  var checkPhoneNumber = function(phone_number){
    $.get('/api/crm/customers/check', {phone_number: phone_number}, function(response, status_str, xhr, undef){
      if(response.success){
        if(isWithoutLicense()){
          addNoneLicenseToCustomer(response.customer);
        }else{
          addVehicleToCustomer(response.customer);
        }
      }else{
        if(isWithoutLicense()){
          newNoneLicenseAndCustomer();
        }else{
          newVehicleAndCustomer();
        }
      }
    });
  }

  var checkVehicle = function(license, phone_number){
    $.get('/api/store_vehicles/search', {license_number: license}, function(response, status_str, xhr, undef){
      if(response.vehicle_id){
        vehicleExist(response.vehicle_id);
      }else{
        if(!!phone_number){
          checkPhoneNumber(phone_number);
        }else{
          newVehicleAndAnonymous();
        }
      }
    });
  }

  var isWithoutLicense = function(){
    return $('#without-license-number').prop('checked');
  }

  var getCustomerName = function(){
    var last_name = getLastName();
    var first_name = getFirstName();
    vehicleAndCustomerHandler.current_customer.set('last_name', last_name);
    vehicleAndCustomerHandler.current_customer.set('first_name', first_name);
    if(last_name && first_name){
      return last_name + first_name;
    }else if(last_name){
      return last_name + '某某';
    }else if(first_name){
      return first_name;
    }else{
      return '匿名客户';
    }
  }

  var getFirstName = function(){
    return $('[name="first_name"]').val().trim();
  }

  var getLastName = function(){
    return $('[name="last_name"]').val().trim();
  }

  var setNewCustomerName = function(){
    return $('.js-customer-name').text(getCustomerName());
  }

  var getPhoneNumber = function(){
    return $(".vehicle-search .js-phone-number").val().replace(/\s/g, '');
  }

  var getLicenseNumber = function(){
    return $(".vehicle-search .js-license-number").val().replace(/\s/g, '');
  }

  var hide_customer_tip = function(){
    return $('.customer-tip').hide();
  }

  var hide_existing_vehicles = function(){
    return $('#existing-vehicles').hide();
  }

  var show_frequenter = function(){
    $('.fresh').hide();
    $('.frequenter').show();
  }

  var show_fresh = function(){
    $('.frequenter').hide();
    $('.fresh').show();
  }

  var phoneNotExists = function(){/*TIP: phone is not exist and didn't input license number or not none-license*/
    hide_customer_tip();
    hide_existing_vehicles();
    show_fresh();
    setNewCustomerName();
    $('.js-phone-not-exists').show();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle();
    vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer();
    vehicle_controller_instance.trigger('vehiclechange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
  }

  var newVehicleAndCustomer = function(){/*TIP: vehicle(license entered but not found) and customer(phone entered but not found) both not exist */
    hide_customer_tip();
    show_fresh();
    setNewCustomerName();
    hide_existing_vehicles();
    $('.js-new-vehicle-and-customer').show();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle({license_number: getLicenseNumber()});
    vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer({phone_number: getPhoneNumber()});
    vehicle_controller_instance.trigger('vehiclechange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
  }

  var newVehicleAndAnonymous = function(){/*TIP: vehicle(license entered but not found) and customer(phone not found) name not fill out*/
    hide_customer_tip();
    show_fresh();
    setNewCustomerName();
    hide_existing_vehicles();
    $('.js-new-vehicle-and-anonymous').show();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle({license_number: getLicenseNumber()});
    vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer({phone_number: getPhoneNumber()});
    vehicle_controller_instance.trigger('vehiclechange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
  }

  var addVehicleToCustomer = function(customer){/*TIP: vehicle(license entered but not found) and customer got */
    hide_customer_tip();
    hide_existing_vehicles();
    show_frequenter();
    $('.js-customer-name').text(customer.full_name);
    $('.js-add-vehicle-to-customer').show();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle({license_number: getLicenseNumber()});
    customerFetch(customer.id);
  }

  var newNoneLicenseAndCustomer = function(){/*TIP: without license but need to register a new customer*/
    hide_customer_tip();
    show_fresh();
    setNewCustomerName();
    hide_existing_vehicles();
    $('.js-new-none-license-and-customer').show();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle({license_number: getLicenseNumber()});
    vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer({phone_number: getPhoneNumber()});
    vehicle_controller_instance.trigger('vehiclechange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
  }

  var addNoneLicenseToCustomer = function(customer){/* TIP: without license but customer got */
    hide_customer_tip();
    show_frequenter();
    hide_existing_vehicles();
    $('.js-customer-name').text(customer.full_name);
    $('.js-add-none-license-to-customer').show();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle({license_number: getLicenseNumber()});
    customerFetch(customer.id);
  }

  var newNoneLicenseAndAnonymous = function(){/*TIP: totally anonymous none-license with none-phone */
    hide_customer_tip();
    setNewCustomerName();
    show_fresh();
    hide_existing_vehicles();
    $('.js-new-none-license-and-anonymous').show();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle({license_number: getLicenseNumber()});
    vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer({phone_number: getPhoneNumber()});
    vehicle_controller_instance.trigger('vehiclechange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
  }

  var reset_all = function(){
    hide_customer_tip();
    hide_existing_vehicles();
    $('#existing-vehicles div.vehicles').html("");
    $('.js-customer-name').text('');
    $('[name="first_name"]').val('');
    $('[name="last_name"]').val('');
    show_frequenter();
    vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle();
    vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer();
    vehicle_controller_instance.trigger('vehiclechange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
  }

  var checkVehicleAndCustomer = function(license, phone_number){
    if(!isWithoutLicense() && !license && !phone_number){
      return reset_all();
    }

    if(isWithoutLicense()){
      if(!phone_number){
        newNoneLicenseAndAnonymous();
      }else{
        checkPhoneNumber(phone_number);
      }
    }else{
      if(!!license && !!phone_number){
        checkVehicle(license, phone_number);
      }else if(!phone_number){
        checkVehicle(license, phone_number);
      }else if(!license){
        getVehiclesByPhone(phone_number);
      }else{
        reset_all();
      }
    }
  }

  function editVehicle(){
    if(!vehicleAndCustomerHandler.current_vehicle){
      vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle();
    }
    if(vehicleAndCustomerHandler.current_vehicle.isNew()){
      showAddVehicleForm();
    }else{
      Mis.Views.editVehicle(vehicleAndCustomerHandler.current_vehicle.attributes);
    }
  }

  function editCustomer(){
    if(!vehicleAndCustomerHandler.current_customer){
      vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer();
    }
    if(vehicleAndCustomerHandler.current_customer.isNew()){
      showAddVehicleForm();
    }else{
      Mis.Views.editCustomer(vehicleAndCustomerHandler.current_customer.attributes);
    }
  }

  function showAddVehicleForm(){
    new Mis.Views.NewCustomerView({
                                    customer: vehicleAndCustomerHandler.current_customer, 
                                    license_number: getLicenseNumber(),
                                    phone_number: getPhoneNumber(),
                                    provisional: isWithoutLicense()
                                  },
                                  newCustomerFormhandle);
  }

  function vehicleExist(vehicle_id){
    if(vehicle_id){
      vehicleAndCustomerHandler.current_vehicle = new Mis.Models.StoreVehicle();
      vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer();
      vehicleAndCustomerHandler.current_vehicle.id = vehicle_id
      vehicleAndCustomerHandler.current_vehicle.fetch({
        success: function(){
          afterVehicleFetch();
        }
      });
    }
  }

  function customerFetch(customer_id){
    if(customer_id){
      vehicleAndCustomerHandler.current_customer = new Mis.Models.StoreCustomer();
      vehicleAndCustomerHandler.current_customer.id = customer_id;
      vehicleAndCustomerHandler.current_customer.fetch({
        success: function(){
          afterCustomerFetch();
        }
      });
    }
  }

  function afterCustomerFetch(){
    vehicle_controller_instance.trigger('customerchange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
    fresh_editors();
  }

  var afterVehicleFetch = function(){
    vehicleAndCustomerHandler.current_customer.set(vehicleAndCustomerHandler.current_vehicle.attributes.store_customer);
    $('.vehicle-search .js-phone-number').val(vehicleAndCustomerHandler.current_customer.attributes.phone_number);
    $('.vehicle-search .js-customer-name').text(vehicleAndCustomerHandler.current_customer.attributes.full_name);
    $('.vehicle-search .js-license-number').val(vehicleAndCustomerHandler.current_vehicle.attributes.license_number);
    $('.fresh').hide();
    $('.frequenter').show();
    $('.customer-tip').hide();
    hide_existing_vehicles();
    vehicle_controller_instance.trigger('vehiclechange', vehicleAndCustomerHandler.current_vehicle, vehicleAndCustomerHandler.current_customer);
    fresh_editors();
  }

  var fresh_editors = function(){
    if($('.completing_vehicle_info').is(':visible')){
      editVehicle();
    }
    if($('.improve_crm_wrap').is(':visible')){
      editCustomer();
    }
  }


  function initVehicleSearch(){
    var $licenseInput = $(".vehicle-search .js-license-number");
    var $phoneInput = $(".vehicle-search .js-phone-number");
    var $withoutLicenseCheckbox = $('#without-license-number');

    $licenseInput.on('acchange', function(){/*handle autocomplete change event*/
      var license = this.value.replace(/\s/g, '').toUpperCase();
      this.value = license;
      var phone_number = getPhoneNumber();
      checkVehicleAndCustomer(license, phone_number);
    });

    $phoneInput.on('change', function(){
      var license = getLicenseNumber();
      var phone_number = this.value.replace(/\s/g, '');
      checkVehicleAndCustomer(license, phone_number);
    });

    $withoutLicenseCheckbox.on('change', function(){
      if(this.checked){
        $licenseInput.val('暂无牌照');
        $licenseInput.attr('readonly', true);
      }else{
        $licenseInput.val('');
        $licenseInput.removeAttr('readonly');
      }
      $licenseInput.trigger('acchange')
    });

    $('.js-customer-name-input').on('change', function(){
      setNewCustomerName();
    });

    $('#existing-vehicles').on('click', '.js-choose-existing-vehicle', function(){
       var vehicle_id = this.dataset.id;
       var license_number = this.dataset.license;
       if(vehicle_id){
         $licenseInput.val(license_number);
         vehicleExist(vehicle_id);
         hide_existing_vehicles();
       }
    })

  };

  function lock(){
    if(!vehicleAndCustomerHandler.isOrdering){
      vehicleAndCustomerHandler.isOrdering = true;
      $('#without-license-number').attr('disabled', true);
      $('.vehicle-search .js-license-number').attr('disabled', true);
      $('.vehicle-search .js-phone-number').attr('disabled', true);
      $('.js-customer-name-input').attr('disabled', true);
    }
  }

  function save_new_vehicle(callback){
    var vehicle_attr = {
                        vehicle:{
                          license_number: getLicenseNumber(),
                          phone_number: getPhoneNumber(),
                          last_name: getLastName(),
                          first_name: getFirstName(),
                          provisional: isWithoutLicense()
                        }
                      };
    $.ajax({
      type: 'POST',
      url: '/api/crm/customers',
      contentType: 'application/json',
      data: JSON.stringify(vehicle_attr),
      success: function(response, status_str, xhr, undef){
        $("#store_vehicle_id").val(response.store_vehicle_id);
        callback.call();
      },
      error: function(){
        ZhanchuangAlert('保存失败请重试');
      }
    })
  }

  function shwoVehicleEssentials(){
    vehicleAndCustomerHandler.shwoVehicleEssentials();
  }

  function VehiclesController(){/*需要在此做一些初始化的工作*/
    _.extend(this, Backbone.Events);
    initVehicleSearch();
    this.editCustomer = editCustomer;
    this.editVehicle = editVehicle;
    this.lock = lock;
    this.save_new_vehicle = save_new_vehicle;
    this.shwoVehicleEssentials = shwoVehicleEssentials;
  }

  var vehicle_controller_instance = null;
  var getVehiclesControllerInstance = function(){
    if(!vehicle_controller_instance){
      vehicle_controller_instance = new VehiclesController();
      shwoVehicleEssentials();
    }
    return vehicle_controller_instance;
  }

  win.$$MIS = $$MIS || {};
  win.$$MIS.getVehiclesControllerInstance = getVehiclesControllerInstance;
})(window, document, jQuery, window.$$MIS);
