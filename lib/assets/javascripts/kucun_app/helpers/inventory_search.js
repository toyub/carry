jQuery(function($){
    $("#root_category").on('change', function(){
        var id = this.value;
        if(!id){
          $('#sub_category').html('<option value=""></option>');
          return false;
        }
        $.get('/ajax/store_material_categories/' + id + '/sub_categories.json', function(data){
          $('#sub_category').html('<option value=""></option>')
          $('#sub_category').append(data.map(function(category){
            return '<option value='+category.id+'>'+ category.name + '</option>';
          }).join(''));
        });
    });

    $("#materials_kucun_depot").on('change', function(){
      if(this.value){
        $("#material_search").attr('action', Routes.materials_kucun_depot_path(this.value));
      }else{
        $("#material_search").attr('action',Routes.kucun_materials_path());
      }
    });

    function set_checked_to_material(material) {
      var material_ids = [];
      var material_len = $('table.check_order > tbody > tr').length;
      for(var i = 0; i < material_len; i++){
        material_ids[i] = $('table.check_order > tbody > tr:eq("' + i +'")').attr('data-id');
      }
      material.checked = false;
      for(var i = 0; i < material_len; i++){
        if(material.id == material_ids[i]){
          material.checked = true;
          break;
        }
      }
    }

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
                set_checked_to_material(inventory.store_material);
                return choice_tmpl(inventory.store_material);
              }).join('');
              callback(html, data);
          });
      }
    };
});
