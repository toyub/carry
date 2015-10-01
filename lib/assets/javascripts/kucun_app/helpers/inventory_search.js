jQuery(function($){
  $("#root_category").on('change', function(){
        var id = this.value;
        $.get(`/ajax/store_material_categories/${id}/sub_categories.json`, function(data){
          $('#sub_category').html('<option value="">所有类别</option>')
          $('#sub_category').append(data.map(function(category){
            return `<option value=${category.id}>${category.name}</option>`;
          }).join(''));
        });
      });
});
