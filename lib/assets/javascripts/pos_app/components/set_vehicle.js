(function(){
  var vehicle_summary_tmpl = JST['pos/orders/vehicle/summary'];
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
    $('.js-phone-not-exists').show();
  }

  var newVehicleAndCustomer = function(){/*TIP: vehicle(license entered but not found) and customer(phone entered but not found) both not exist */
    hide_customer_tip();
    show_fresh();
    $('.js-customer-name').text(getCustomerName());
    $('.js-new-vehicle-and-customer').show();
  }

  var newVehicleAndAnonymous = function(){/*TIP: vehicle(license entered but not found) and customer(phone not found) name not fill out*/
    hide_customer_tip();
    show_fresh();
    $('.js-new-vehicle-and-anonymous').show();
  }

  var addVehicleToCustomer = function(customer){/*TIP: vehicle(license entered but not found) and customer got */
    hide_customer_tip();
    show_frequenter();
    $('.js-customer-name').text(customer.full_name);
    $('.js-add-vehicle-to-customer').show();
  }

  var newNoneLicenseAndCustomer = function(){/*TIP: without license but need to register a new customer*/
    hide_customer_tip();
    show_fresh();
    $('.js-customer-name').text(getCustomerName());
    $('.js-new-none-license-and-customer').show();
  }

  var addNoneLicenseToCustomer = function(customer){/* TIP: without license but customer got */
    hide_customer_tip();
    show_frequenter();
    $('.js-customer-name').text(customer.full_name);
    $('.js-add-none-license-to-customer').show();
  }

  var newNoneLicenseAndAnonymous = function(){/*TIP: totally anonymous none-license with none-phone */
    show_fresh();
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

  var getPhoneNumber = function(){
    return $(".vehicle-search .js-phone-number").val().trim();
  }

  var getLicenseNumber = function(){
    return $(".vehicle-search .js-license-number").val().trim();
  }

  var checkVehicle = function(license, phone_number){
    $.get('/api/store_vehicles/search', {license_number: license}, function(response, status_str, xhr, undef){
      if(response.vehicle_id){
        Mis.current_vehicle.id = response.vehicle_id;
        Mis.current_vehicle.fetch();
      }else{
        if(!!phone_number){
          checkPhoneNumber(phone_number);
        }else{
          newVehicleAndAnonymous();
        }
      }
    });
  }

  var checkVehicleAndCustomer = function(license, phone_number){
    if(isWithoutLicense()){
      if(!phone_number){
        newNoneLicenseAndAnonymous();
      }else{
        checkPhoneNumber(phone_number);
      }
    }else{
      if(!license && !phone_number){
        reset_all();
      }else if(!phone_number){
        checkVehicle(license, phone_number);
      }else{
        getVehiclesByPhone(phone_number);
      }
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
        show_frequenter();
        $('#existing-vehicles div.vehicles').html(html);
        hide_customer_tip();
        $('#existing-vehicles').show();
      }else{
        phoneNotExists();
      }
    });
  }

  function reset_all(){
    hide_customer_tip();
    hide_existing_vehicles();
    $('#existing-vehicles div.vehicles').html("");
    $('.js-customer-name').text('');
    $('[name="first_name"]').val('');
    $('[name="last_name"]').val('');
    show_frequenter();
  }

  Mis.SetVehicle = function(){
    var $licenseInput = $(".vehicle-search .js-license-number");
    var $phoneInput = $(".vehicle-search .js-phone-number");
    var $withoutLicenseCheckbox = $('#without-license-number');

    $licenseInput.on('change', function(){
      this.value = this.value.trim().toUpperCase();
      var license = this.value;
      var phone_number = getPhoneNumber();
      if(!phone_number && !license){
        reset_all();
        return;
      }
      checkVehicleAndCustomer(license, phone_number);
    });

    $phoneInput.on('change', function(){
      var license = getLicenseNumber();
      var phone_number = this.value.trim();
      if(!phone_number && !license){
        reset_all();
        return;
      }
      if(!isWithoutLicense() && !license){
        getVehiclesByPhone(phone_number);
      }else{
        checkVehicleAndCustomer(license, phone_number);
      }
    });

    $withoutLicenseCheckbox.on('change', function(){
      if(this.checked){
        hide_existing_vehicles();
        $('.vehicle-search .js-license-number').val('暂无牌照');
        $('.vehicle-search .js-license-number').attr('readonly', true);
        $('.vehicle-search .js-license-number').trigger('change');
      }else{
        $('.vehicle-search .js-license-number').val('');
        $('.vehicle-search .js-license-number').removeAttr('readonly');
        hide_customer_tip();
        var phone_number = getPhoneNumber();
        if(!!phone_number){
          getVehiclesByPhone(phone_number);
        }else{
          reset_all();
        }
      }
    });

    $('.js-customer-name-input').on('change', function(){
      setNewCustomerName();
    });
  };
})();
