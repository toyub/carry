$(function() {
  showVehicleBrands();
  $(document).on('change', '#brand', showVehicleSeries);
  $(document).on('change', '#series', showVehicleModels);
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
  emptyModels();
  emptySeries();
  if(brand_id != ''){
    $.get('/api/vehicle_brands/' + brand_id + '/vehicle_manufacturers', function(manufacturers) {
      appendManufacturersWithSeries(manufacturers);
    });
  }

}

function showVehicleModels() {
  var series_id = $('#series').val();
  emptyModels();
  if(series_id != ''){
    $.get('/api/vehicle_series/' + series_id + '/vehicle_models', function(models) {
      $.each(models, function(idx, model) {
        $('#model').append('<option value="'+ model.id +'">' + model.name + '</option>');
      });
    });
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
