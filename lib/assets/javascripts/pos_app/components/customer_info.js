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

          $.get('/ajax/geo/1/states.json', function(response){
            var oldid = $('#province').data('oldid');
            var states = response;
            var html = states.map(function(state){
              var selected = '';
              if(state.code == oldid){
                selected = 'selected="selected"'
              }
              return "<option " + selected + " value='" + state.code + "'>"+ state.name +"</option>";
            }).join('');
            $("#province").html('<option value="">请选择</option>' + html);

            if(entity.regions && entity.regions.length > 0){
              var oldid = $('#region').data('oldid');
              var html = entity.regions.map(function(region){
                var selected = '';
                if(region.code == oldid){
                  selected = 'selected="selected"';
                }
                return "<option " + selected + " value='" + region.code + "'>"+ region.name +"</option>";
              }).join('');
              $('#region').html(html);
            }

            if(entity.cities && entity.cities.length > 0){
              var oldid = $('#city').data('oldid');
              var html = entity.cities.map(function(city){
                var selected = '';
                if(city.code == oldid){
                  selected = 'selected="selected"';
                }
                return "<option " + selected + " value='" + city.code + "'>"+ city.name +"</option>";
              }).join('') ;
              $('#city').html(html);
            }
          });
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
  }

  $(document).on('submit', '.improve_crm_wrap form', function(evt){
    evt.preventDefault();
    var attrs = $(this).serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true});
    var action_url = this.action;
    $.ajax({
      url: action_url,
      type: 'PUT',
      data: attrs,
      success: function(response){
        Mis.Vues.VechileInfo.vehicleInfoData.store_customer = response;
        ZhanchuangAlert("客户信息更新成功!");
      },
      error: function(){
        ZhanchuangAlert("保存到服务器失败，请重试!");
      }
    });
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
