Mis.OrderVueObject = function(handle){
    Mis.Vues.OrderFormView = new Vue(Mis.Vues.Opts.order_form);
    Mis.Vues.MaterialItem = new Vue(Mis.Vues.Opts.material);
    Mis.Vues.ServiceItem = new Vue(Mis.Vues.Opts.service);
    Mis.Vues.PackageItem = new Vue(Mis.Vues.Opts.package);

    Mis.Vues.MaterialItem.$watch('totalPrice', function(oldVal, newVal){
      Mis.Vues.OrderFormView.amount = Mis.Vues.MaterialItem.totalPrice +
          Mis.Vues.ServiceItem.totalPrice +
          Mis.Vues.PackageItem.totalPrice;
    });

    Mis.Vues.ServiceItem.$watch('totalPrice', function(oldVal, newVal){
      Mis.Vues.OrderFormView.amount = Mis.Vues.MaterialItem.totalPrice +
          Mis.Vues.ServiceItem.totalPrice +
          Mis.Vues.PackageItem.totalPrice;
    });

    Mis.Vues.PackageItem.$watch('totalPrice', function(oldVal, newVal){
      Mis.Vues.OrderFormView.amount = Mis.Vues.MaterialItem.totalPrice +
          Mis.Vues.ServiceItem.totalPrice +
          Mis.Vues.PackageItem.totalPrice;
    });

    Mis.Vues.MaterialItem.$on('remove:item', function(vue_item, vue_remove_fun){
      $('#js-orderables-materials input[data-itemid='+ vue_item.orderable_id +']').removeAttr('checked');
      if(handle.order && vue_item.id){
        var ordered_item = handle.order.materials.items.find(function(item){return item.id == vue_item.id});
        if(ordered_item){
          if(confirm('确定取消订单商品:【'+ ordered_item.name +'】？')){
            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + handle.order.id + '/items/' + ordered_item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
                Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
                $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
                $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            $('#js-orderables-materials input[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
          }
        }else{
          vue_remove_fun.call();
          Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
          $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
          $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
        }
      }else{
        vue_remove_fun.call();
        Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
        $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
        $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
      }
    });

    Mis.Vues.PackageItem.$on('remove:item', function(vue_item, vue_remove_fun){
      $('#js-orderables-packages input[data-itemid='+ vue_item.orderable_id +'].package-checkbox').removeAttr('checked');
      var removeSubItemFunc = function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);}
      if(handle.order && vue_item.id){
        var ordered_item = handle.order.packages.items.find(function(item){return item.id == vue_item.id});
        if(ordered_item){
          if(confirm('确定取消订单商品:【'+ ordered_item.name +'】？')){
            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + handle.order.id + '/items/' + ordered_item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
                Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(removeSubItemFunc);
                Mis.Vues.MaterialItem.items = Mis.Vues.MaterialItem.items.filter(removeSubItemFunc);
                $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
                $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            $('#js-orderables-packages input[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
          }
        }else{
          vue_remove_fun.call();
          Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(removeSubItemFunc);
          Mis.Vues.MaterialItem.items = Mis.Vues.MaterialItem.items.filter(removeSubItemFunc);
          $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
          $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
        }
      }else{
        vue_remove_fun.call();
        Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(removeSubItemFunc);
        Mis.Vues.MaterialItem.items = Mis.Vues.MaterialItem.items.filter(removeSubItemFunc);
        $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
        $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
      }
    });

    Mis.Vues.ServiceItem.$on('remove:item', function(vue_item, vue_remove_fun){

      switch(vue_item.orderable_type){
        case 'StoreMaterialSaleinfoService':
          if(vue_item.store_customer_asset_item_id){
            $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').removeAttr('checked');
          }else{
            $('input.js-material-service[data-itemid='+ vue_item.orderable_id +']').removeAttr('checked');
          }
          break;
        case 'StoreService':
          if(vue_item.from_customer_asset){
            if(vue_item.store_customer_asset_item_id){
              $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').removeAttr('checked');
            }else{
              $('input.js-package-service[data-itemid='+ vue_item.package_item_id +']').removeAttr('checked');
            }
          }else{
            $('#js-orderables-services input[data-itemid='+ vue_item.orderable_id +']').removeAttr('checked');
          }
          break;
        default:
          console.log(vue_item.orderable_type)
      }

      if(handle.order && vue_item.id){
        var ordered_item = handle.order.services.items.find(function(item){return item.id == vue_item.id});
        if(ordered_item){
          if(confirm('确定取消订单商品:【'+ ordered_item.name +'】？')){
            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + handle.order.id + '/items/' + ordered_item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            switch(vue_item.orderable_type){
              case 'StoreMaterialSaleinfoService':
                if(vue_item.store_customer_asset_item_id){
                  $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').prop('checked', true);
                }else{
                  $('input.js-material-service[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
                }
                break;
              case 'StoreService':
                if(vue_item.from_customer_asset){
                  if(vue_item.store_customer_asset_item_id){
                    $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').prop('checked', true);
                  }else{
                    $('input.js-package-service[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
                  }
                }else{
                  $('#js-orderables-services input[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
                }
                break;
              default:
                console.log(vue_item.orderable_type)
            }

          }
        }else{
          vue_remove_fun.call();
        }
      }else{
        vue_remove_fun.call();
      }
    });
  
}