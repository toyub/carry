(function(win, doc, $, $$MIS){
  var vehicle_summary_tmpl = JST['pos/orders/vehicle/summary'];
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
        instance.trigger('vehicleexist', response.vehicle_id);
      }else{
        if(!!phone_number){
          checkPhoneNumber(phone_number);
        }else{
          newVehicleAndAnonymous();
        }
      }
    });
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
  }

  var newVehicleAndCustomer = function(){/*TIP: vehicle(license entered but not found) and customer(phone entered but not found) both not exist */
    hide_customer_tip();
    show_fresh();
    setNewCustomerName();
    hide_existing_vehicles();
    $('.js-new-vehicle-and-customer').show();
  }

  var newVehicleAndAnonymous = function(){/*TIP: vehicle(license entered but not found) and customer(phone not found) name not fill out*/
    hide_customer_tip();
    show_fresh();
    setNewCustomerName();
    hide_existing_vehicles();
    $('.js-new-vehicle-and-anonymous').show();
  }

  var addVehicleToCustomer = function(customer){/*TIP: vehicle(license entered but not found) and customer got */
    hide_customer_tip();
    hide_existing_vehicles();
    show_frequenter();
    $('.js-customer-name').text(customer.full_name);
    $('.js-add-vehicle-to-customer').show();
  }

  var newNoneLicenseAndCustomer = function(){/*TIP: without license but need to register a new customer*/
    hide_customer_tip();
    show_fresh();
    setNewCustomerName();
    hide_existing_vehicles();
    $('.js-new-none-license-and-customer').show();
  }

  var addNoneLicenseToCustomer = function(customer){/* TIP: without license but customer got */
    hide_customer_tip();
    show_frequenter();
    hide_existing_vehicles();
    $('.js-customer-name').text(customer.full_name);
    $('.js-add-none-license-to-customer').show();
  }

  var newNoneLicenseAndAnonymous = function(){/*TIP: totally anonymous none-license with none-phone */
    hide_customer_tip();
    setNewCustomerName();
    show_fresh();
    hide_existing_vehicles();
    $('.js-new-none-license-and-anonymous').show();
  }


  var isWithoutLicense = function(){
    return $('#without-license-number').prop('checked');
  }

  var getCustomerName = function(){
    var last_name = $('[name="last_name"]').val().trim();
    var first_name = $('[name="first_name"]').val().trim();
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

  var setNewCustomerName = function(){
    return $('.js-customer-name').text(getCustomerName());
  }

  var getPhoneNumber = function(){
    return $(".vehicle-search .js-phone-number").val().trim();
  }

  var getLicenseNumber = function(){
    return $(".vehicle-search .js-license-number").val().trim();
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

  function reset_all(){
    hide_customer_tip();
    hide_existing_vehicles();
    $('#existing-vehicles div.vehicles').html("");
    $('.js-customer-name').text('');
    $('[name="first_name"]').val('');
    $('[name="last_name"]').val('');
    show_frequenter();
    instance.trigger('resetvehicle', null);
  }

  var afterVehicleFetch = function(customer){
    $('.vehicle-search .js-phone-number').val(customer.phone_number);
    $('.vehicle-search .js-customer-name').text(customer.full_name);
    $('.fresh').hide();
    $('.frequenter').show();
    $('.customer-tip').hide();
    hide_existing_vehicles();
  }

  var VehicleSearch = function(){
    _.extend(this, Backbone.Events);
    var $licenseInput = $(".vehicle-search .js-license-number");
    var $phoneInput = $(".vehicle-search .js-phone-number");
    var $withoutLicenseCheckbox = $('#without-license-number');

    $licenseInput.on('acchange', function(){/*autocomplete change event*/
      var license = this.value.trim().toUpperCase();
      this.value = license;
      var phone_number = getPhoneNumber();
      checkVehicleAndCustomer(license, phone_number);
    });

    $phoneInput.on('change', function(){
      var license = getLicenseNumber();
      var phone_number = this.value.trim();
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
         instance.trigger('vehicleexist', vehicle_id);
         hide_existing_vehicles();
       }
    })

    this.afterVehicleFetch = afterVehicleFetch;
  };

  var instance = null;
  win.$$MIS = $$MIS || {};
  win.$$MIS.getVehicleSearchInstance = function(){
    if(!instance){
      instance = new VehicleSearch();
    }
    return instance;
  }
})(window, document, jQuery, window.$$MIS);
