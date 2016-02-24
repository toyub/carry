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
      $('#brand').append($('<option></option>').attr('value', brand.id).text(brand.name));
    });
  });
}

function showVehicleSeries() {
  var brand_id = $('#brand').find(':selected').val();
  $.get('/api/vehicle_brands/' + brand_id + '/vehicle_manufacturers', function(manufacturers) {
    emptySeries();
    emptyModels();
    appendManufacturersWithSeries(manufacturers);
  });
}

function showVehicleModels() {
  if($('#series').find(':selected').text() != '请选择'){
    var series_id = $('#series').find(':selected').val();
    $.get('/api/vehicle_series/' + series_id + '/vehicle_models', function(models) {
      emptyModels();
      $.each(models, function(idx, model) {
        $('#model').append($('<option></option>').attr('value', model.id).text(model.name));
      });
    });
  }
}

function emptySeries() {
  $('#series').find('optgroup').remove().end();
}

function emptyModels() {
  $('#model').find('option').remove().end().append($('<option>请选择</option>'));
}

function appendManufacturersWithSeries(manufacturers) {
  $.each(manufacturers, function(idx, manufacturer) {
    var optgroup = $('<optgroup>').attr('label', manufacturer.name);
    $.each(manufacturer.series, function(idx, s) {
      optgroup.append($('<option></option>').attr('value', s.id).text(s.name));
    });
    $('#series').append(optgroup);
  });
}

function preventDefault(e) {
  e.preventDefault();
}
