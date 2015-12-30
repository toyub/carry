(function(win){

    var fill_state_select = function (country_code){
      var url ="/ajax/geo/" + country_code + "/states.json";
      $.get(url, function(data){
        var x = data.map(function(state){
          return "<option value='" + state.code + "'>" + state.name + "</option>";
        }).join("");
        $("[name='store_supplier[location_state_code]']").html(x);
        if(data[0]){
          fill_city_select(country_code, data[0].code);
        }
      });
    };

    var fill_city_select  = function(country_code, state_code){
      var url = "/ajax/geo/" + country_code + "/states/" + state_code + "/cities.json";
      $.get(url, function(data){
        var x = data.map(function(state){
          return "<option value='" + state.code + "'>" + state.name + "</option>";
        }).join("");
        $("[name='store_supplier[location_city_code]']").html(x);
      });
    };

    var fill_sub_category_select = function(root_category_id){
      var url = "/kucun/material_categories/"+ root_category_id +"/sub_categories";
      $.get(url, function(material_categories){
        var x = material_categories.map(function(category){
          return "<option value='"+ category.id + "'>" + category.name +"</option>";
        }).join("");
        $('[name="store_supplier[store_material_category_id]"]').html(x);
      });
    }

    function supplier_edit(){
      $('select').on('change', function(){
        switch(this.name){
          case 'store_supplier[location_country_code]':
            $("[name='store_supplier[location_state_code]']").html("");
            $("[name='store_supplier[location_city_code]']").html("");
            fill_state_select(this.value);
            break;
          case 'store_supplier[location_state_code]':
            $("[name='store_supplier[location_city_code]']").html("");
            var country_code = $("[name='store_supplier[location_country_code]']").val();
            fill_city_select(country_code, this.value);
            break;
          case 'store_supplier[location_city_code]':
            break;
          case 'store_supplier[store_material_root_category_id]':
            $("[name='store_supplier[store_material_category_id]']").html('');
            fill_sub_category_select(this.value);
            break;
          default:
            break;
        }
      });
    }

    win.supplier_init = supplier_edit;

})(window);
