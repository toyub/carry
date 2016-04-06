(function(){
  var hide_customer_tip = function(){
    return $('.customer-tip').hide();
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
        hide_customer_tip();
        $('.js-customer-name').text(response.customer.full_name);
        $('.fresh').hide();
        $('.frequenter').show();
        if(isWithoutLicense()){
          $('.js-add-none-license-to-customer').show();
        }else{
          $('.js-add-vehicle-to-customer').show();
        }
      }else{
        hide_customer_tip();
        $('.frequenter').hide();
        $('.fresh').show();
        $('.js-customer-name').text(getCustomerName());
        if(isWithoutLicense()){
          $('.js-new-none-license-and-customer').show();
        }else{
          $('.js-new-vehicle-and-customer').show();
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

  var checkVehicle = function(license, phone){
    $.get('/api/store_vehicles/search', {license_number: license}, function(response, status_str, xhr, undef){
      if(response.vehicle_id){
        Mis.current_vehicle.id = response.vehicle_id;
        Mis.current_vehicle.fetch();
      }else{
        if(!!phone){
          checkPhoneNumber(phone);
        }else{
          hide_customer_tip();
          $('.frequenter').hide();
          $('.fresh').show();
          $('.js-new-vehicle-and-anonymous').show();
        }
      }
    });
  }

  var checkVehicleAndCustomer = function(license, phone){
    if(isWithoutLicense()){
      if(!phone){
        $('.frequenter').hide();
        $('.fresh').show();
        $('.js-new-none-license-and-anonymous').show();
      }else{
        checkPhoneNumber(phone);
      }
    }else{
      checkVehicle(license, phone);
    }
  }

  Mis.SetVehicle = function(){
    var $licenseInput = $(".vehicle-search .js-license-number");
    var $phoneInput = $(".vehicle-search .js-phone-number");
    var $withoutLicenseCheckbox = $('#without-license-number');

    $licenseInput.on('change', function(){
      this.value = this.value.trim().toUpperCase();
      var license = this.value;
      var phone = getPhoneNumber();
      checkVehicleAndCustomer(license, phone);
    });

    $phoneInput.on('change', function(){
      var license = getLicenseNumber();
      var phone = this.value.trim();
      checkVehicleAndCustomer(license, phone);
    });

    $withoutLicenseCheckbox.on('change', function(){
      if(this.checked){
        $('.vehicle-search .js-license-number').val('暂无牌照');
        $('.vehicle-search .js-license-number').attr('readonly', true);
        $('.vehicle-search .js-license-number').trigger('change');
      }else{
        $('.vehicle-search .js-license-number').val('');
        $('.vehicle-search .js-license-number').removeAttr('readonly');
      }
    });

    $('.js-customer-name-input').on('change', function(){
      setNewCustomerName();
    });
  };
})();
