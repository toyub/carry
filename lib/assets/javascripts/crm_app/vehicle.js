$(function() {
  $('.datepicker').datetimepicker({
    format: 'Y-m-d',
    lang: 'ch',
    timepicker: false
  });

  showVehicleBrands();
  $(document).on('change', '#brand', showVehicleSeries);
  $(document).on('change', '#series', showVehicleModels);
  $(document).on('keydown', '.readonly', preventDefault);
});

function showVehicleBrands() {
  $.get('/api/vehicle_brands', function(brands){
    $.each(brands, function(idx, brand) {
      $('#brand').append('<option value="'+ brand.id +'">' + brand.name + '</option>');
    });
  });
}

function showVehicleSeries() {
  var brand_id = $('#brand').val();
  if(brand_id != ''){
    $.get('/api/vehicle_brands/' + brand_id + '/vehicle_manufacturers', function(manufacturers) {
      emptySeries();
      emptyModels();
      appendManufacturersWithSeries(manufacturers);
    });
  }
  else{
    emptySeries();
    emptyModels();
  }
}

function showVehicleModels() {
  var series_id = $('#series').val();
  if(series_id != ''){
    $.get('/api/vehicle_series/' + series_id + '/vehicle_models', function(models) {
      emptyModels();
      $.each(models, function(idx, model) {
        $('#model').append('<option value="'+ model.id +'">' + model.name + '</option>');
      });
    });
  }
  else{
    emptyModels();
  }
}

function emptySeries() {
  $('#series').html('<option value>请选择</option>');
}

function emptyModels() {
  $('#model').html('<option value>请选择</option>');
}

function appendManufacturersWithSeries(manufacturers) {
  $.each(manufacturers, function(idx, manufacturer) {
    var optgroup = $('<optgroup>').attr('label', manufacturer.name);
    $.each(manufacturer.series, function(idx, s) {
      optgroup.append('<option value="'+ s.id +'">' + s.name + '</option>');
    });
    $('#series').append(optgroup);
  });
}

function preventDefault(e) {
  e.preventDefault();
}
