(function(win, Mis){
  var tmpl = JST["pos/orders/customer_info"];
  var url = '/api/store_customer_entities/';

  Mis.Views.editCustomer = function(vehicle) {
    if(vehicle.license_number){
      if(vehicle.store_customer){
        $.get(url + vehicle.store_customer.store_customer_entity_id, function(response){
          var entity = response;
          entity.url = url + vehicle.store_customer.store_customer_entity_id
          $('div.right_information').children().hide();
          $('.improve_crm_wrap').html(tmpl(entity));
          $('.improve_crm_wrap').show();
        });
        
      }else{
        var entity =  {
          url: url,
          store_customer:{},
          store_customer_settlement: {},
          regions: {}
        };
        $('div.right_information').children().hide();
        $('.improve_crm_wrap').html(tmpl(entity));
        $('.improve_crm_wrap').show();
      }
    }
    $.get('/ajax/geo/1/states.json', function(response){
      var states = response;
      var html = states.map(function(state){
        return "<option value='" + state.code + "'>"+ state.name +"</option>";
      }).join('');
      $("#province").html('<option value="">请选择</option>' + html);
    })
  }

  $(document).on('submit', '.improve_crm_wrap form', function(evt){
    var attrs = $(this).serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true});
    var action_url = this.action;
    if(attrs.store_customer_entity.id){
      $.ajax({
        url: action_url,
        type: 'PUT',
        data: attrs,
        success: function(){},
        error: function(){}
      });
    }else{
      $.ajax({
          url: action_url,
          type: 'POST',
          data: attrs,
          success: function(){},
          error: function(){}
        });
    }
    console.log(attrs, url)
    return false;
  });

  $(document).on('change', '#province', function(){
    $("#region").html('<option value=""></option>')
    $.get("/api/store_customer_entities/cities", {province: this.value}, function(cities){
      var html = cities.map(function(city){
        return "<option value='" + city.code + "'>" + city.name + "</option>";
      }).join('');
      $('#city').html('<option value="">请选择</option>' + html);
    });
  });

  $(document).on('change', '#city', function(){
    $.get("/api/store_customer_entities/regions", {province: $("#province").val(), city: this.value}, function(response){
      var regions = response;
      var html = regions.map(function(region){
        return "<option value='" + region.code + "'>" + region.name + "</option>";
      }).join('');
      $("#region").html(html);
    });
  });

  $(document).on('change', '#credit', function(){
    if(this.value == 'custom'){
      $('#credit_limit').removeAttr('disabled');
    }else{
      $("#credit_limit").val('').attr('disabled', true);
    }
  });
})(window, Mis)