jQuery(function($){
  $("#root_category").on('change', function(){
        var id = this.value;
        $.get('/ajax/store_material_categories/' + id + '/sub_categories.json', function(data){
          $('#sub_category').html('<option value="">所有类别</option>')
          $('#sub_category').append(data.map(function(category){
            return '<option value='+category.id+'>'+ category.name + '</option>';
          }).join(''));
        });
      });

      window.InventorySearch = {
        query_data: function(){
            var keyword = $('#keyword').val().trim();
            var depot_id =  $('#depot_id').val();
            var root_category = $("#root_category").val();
            var category = $('#sub_category').val();
            return  {
                          name: keyword,
                          depot_id:depot_id,
                          root_category_id: root_category,
                          category_id: category
                      };
        },
        search: function(query_data, choice_tmpl, callback) {
            $.get('/ajax/store_materials/inventories.json',query_data, function(data){
              var html = data.map(function(inventory, idx, collection, undef){
                inventory.store_material.quantity = inventory.quantity;
                inventory.store_material.depot_name = inventory.depot_name;
                inventory.store_material.depot_id = inventory.store_depot_id;
                inventory.store_material.inventory_id = inventory.id;
                inventory.store_material.idx = idx+1;
                return choice_tmpl(inventory.store_material);
              }).join('');
              callback(html, data);
          });
      }
  };

      
});
