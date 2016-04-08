(function(win, Mis){
  var tmpl = JST["pos/orders/vehicle_detail_info"];
  Mis.Views.editVehicle = function(vehicle) {
    vehicle.vehicle_brands = $('#vehicle_brands').data('brands');
    $('.completing_vehicle_info').html(tmpl(vehicle));
    $('div.right_information').children().hide();
    $('.completing_vehicle_info').show();
  }

  $(document).on('change', "[name='vehicle[vehicle_brand_id]']", function(){
    var url = "/api/vehicle_brands/" + this.value + "/vehicle_manufacturers";

    $.ajax({
      method: "GET",
      url: url,
    }).done(function(manufacturers){
      var html = '<option value="">请选择</option>';
      html += manufacturers.map(function(manufacturer){
        var manufacturer_html = '<optgroup label="'+'manufacturer.name'+'">'
        manufacturer_html += manufacturer.series.map(function(series){
          return '<option value='+ series.id +'>' + series.name + '</option>';
        }).join('');
        manufacturer_html += '</optgroup>';
        return manufacturer_html;
      });
      
      $('.js-select-vehicle-series').html(html);
    }).fail(function(e){})
  });

  $(document).on('change', "[name='vehicle[vehicle_series_id]']", function(){
    var series_id = this.value;
    if(series_id){
      var url = "/api/vehicle_series/" + this.value + "/vehicle_models";
      $.ajax({
        method: "GET",
        url: url,
      }).done(function(vehicle_models){
        var html = "";
        html += vehicle_models.map(function(model){
          return '<option value=' + model.id + '>' + model.name + '</option>'
        }).join('');
        $('.js-select-vehicle-model').html(html);
      }).fail(function(e){})
    }else{
      $('.js-select-vehicle-model').html('<option value="">请选择</option>');
    }
  })

  $(document).on('submit', '#js-update-vehicle', function(evt){
    evt.preventDefault();
    var $form = $(evt.target);
    var _attrs = $form.serializeJSON();
    var url = $form.data('action');
    $.ajax({
      type: 'PUT',
      url: url,
      data: JSON.stringify(_attrs),
      contentType: 'application/json',
      success: function(response, status_str, xhr, undef){
        ZhanchuangAlert('保存成功!');
      },
      error: function(){
        ZhanchuangAlert('保存失败，请重试!');
      }
    })
  });
})(window, Mis)
