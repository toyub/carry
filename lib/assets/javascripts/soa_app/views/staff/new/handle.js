jQuery(function($){
  $('#content').on('change', '[name="staff[store_department_id]"]', function(){
    $.get('/api/store_departments/'+this.value+'/store_positions.json', function(positions){
      var options = positions.map(function(position){
        return '<option value="'+ position.id +'">'+ position.name +'</option>'
      });
      $('[name="staff[store_position_id]"]').html(options.join(''));
    });
  })
});