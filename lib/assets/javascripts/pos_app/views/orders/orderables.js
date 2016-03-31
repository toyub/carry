(function(win, Backbone, $, Mis){
   var material_tmpl = JST["pos/orders/orderables/material"];
   var service_tmpl  = JST["pos/orders/orderables/service"];
   var package_tmpl  = JST["pos/orders/orderables/package"];
   var assets_tmpl = JST["pos/orders/orderables/asset"];
   var cached_sub_categories = {};

   var OrderableTypes = ['StoreMaterialSaleinfo', 'StoreMaterialSaleinfoService', 'StoreService', 'StorePackage'];
   var ItemDeleteTypes = ['Material', 'MaterialService', 'Service', 'Package', 'PackageService', 'AssetService'];

   var showSubcategoriesOptions = function(categories){
      var html = '<option value="">全部</option>';
      categories.forEach(function(category){
        html += '<option value="' + category.id + '">'+ category.name +'</option>';
      });
      $('[name="store_material_category_id"]').html(html);
   };
   var OrderablesView = Backbone.View.extend({
    el: ".store-order-item-block",
    template: JST["pos/orders/orderables"],
    events: {
      "click .order_items_category li": "showItem",
      'change input.service-checkbox': 'toggleServiceItem',
      'change input.package-checkbox': 'togglePackageItem',
      'change input.material-checkbox': 'toggleMaterialItem',
      'change .js-orderables-assets .js-chose-asset': 'toggleAssetServiceItem',
      'change .js-orderables-materials .js-material-service': 'toggleMaterialServiceItem',
      'change .js-orderables-packages .js-package-service': 'togglePackageServiceItem',
      'submit #search-materials': 'searchMaterials',
      'submit #search-services': 'searchServices',
      'submit #search-packages': 'searchPackages',
      'change [name="store_material_root_category_id"]': 'showSubcategories',
      'click .js-orderables-assets i.js-detail': 'toggleDetail'
    },
    initialize: function(){
      this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos();
      this.packageCollection = new Mis.Collections.StorePackages();
      this.serviceCollection = new Mis.Collections.StoreServices();

      this.loadOnce();
    },

    searchMaterials: function(evt){
      evt.preventDefault();
      var search_params = $(evt.target).serializeJSON();
      this.loadMaterials(search_params);
    },

    searchServices: function(evt){
      evt.preventDefault();
      var search_params = $(evt.target).serializeJSON();
      this.loadServices(search_params);
    },

    searchPackages: function(evt){
      evt.preventDefault();
      var search_params = $(evt.target).serializeJSON();
      this.loadPackages(search_params);
    },

    showSubcategories: function(evt){
      var root_category_id = evt.target.value;
      if(!!root_category_id){
        var sub_categories = cached_sub_categories['category'+root_category_id];
        if(sub_categories){
          showSubcategoriesOptions(sub_categories);
        }else{
          $.get('/ajax/store_material_categories/'+ root_category_id +'/sub_categories.json', function(response){
            cached_sub_categories['category'+root_category_id] = response;
            showSubcategoriesOptions(response);
          });
        }
      }else{
        $('[name="store_material_category_id"]').html('<option value="">全部</option>');
      }
    },

    checkSelectedServices: function(){
      Mis.Vues.ServiceItem.items.forEach(function(item, idx){
        if(item.from_customer_asset){
          if(!item.store_customer_asset_item_id){
            $('#'+item.package_type + item.package_id).show();
            $('#'+item.package_type + item.package_id + ' [data-itemid='+ item.assetable_id +']').attr('checked', true);
          }
        }else{
          $('#js-orderables-services input[data-itemid='+ item.orderable_id +']').attr('checked', true);
        }
      });
    },

    checkSelectedMaterials: function(){
      Mis.Vues.MaterialItem.items.forEach(function(item, idx){
        $('#js-orderables-materials input[data-itemid='+ item.orderable_id +'].material-checkbox').attr('checked', true);
        $('#'+item.orderable_type+item.orderable_id).show();
      });
    },

    checkSelectedPackages: function(){
      Mis.Vues.PackageItem.items.forEach(function(item, idx){
        $('#js-orderables-packages input[data-itemid='+ item.orderable_id +'].package-checkbox').attr('checked', true);
        $('#'+item.orderable_type+item.orderable_id).show();
      });
    },

    toggleServiceItem: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      if(!(Mis.Vues.VechileInfo.vehicleInfoData && Mis.Vues.VechileInfo.vehicleInfoData.id)){
        target.checked=false;
        $.alert({text: "先选择车辆"});
        return false;
      }

      if(target.checked){
        var service = this.serviceCollection.find({id: id});
        var _attrs = service.toItemAttrs(Mis.Vues.VechileInfo.vehicleInfoData.store_customer);
        Mis.Vues.ServiceItem.items.push(_attrs);
      }else{
        var idx = Mis.Vues.ServiceItem.items.findIndex(function(item){
          return item.orderable_type == 'StoreService' && !item.from_customer_asset && item.orderable_id == id;
        });
        Mis.Vues.ServiceItem.removeItem(idx);
      }
    },

    toggleMaterialItem: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      if(!(Mis.Vues.VechileInfo.vehicleInfoData && Mis.Vues.VechileInfo.vehicleInfoData.id)){
        target.checked=false;
        $.alert({text: "先选择车辆"});
        return false;
      }
      if(target.checked){
        var material = this.materialCollection.find({id: id});
        var _attrs = material.toItemAttrs(Mis.Vues.VechileInfo.vehicleInfoData.store_customer)
        Mis.Vues.MaterialItem.items.push(_attrs);
        if(material.get('service_needed')){
          $(target.parentElement.parentElement.parentElement.nextElementSibling).show();
        }
      }else{
        var idx = Mis.Vues.MaterialItem.items.findIndex(function(item){
          return item.orderable_type == 'StoreMaterialSaleinfo' && !item.from_customer_asset && item.orderable_id == id;
        });
        Mis.Vues.MaterialItem.removeItem(idx);
      }
    },

    toggleMaterialServiceItem: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      var parent_id = parseInt(target.dataset.parentid);
      var material = this.materialCollection.find({id: parent_id});
      var material_service = material.attributes.services.find(function(service){return service.id==id;});

      if(target.checked){
          var _attrs = {
          name: material_service.name,
          orderable_id: id,
          orderable_type: 'StoreMaterialSaleinfoService',
          package_type: 'StoreMaterialSaleinfo',
          package_id: material.id,
          package_item_type: 'StoreMaterialSaleinfoService',
          package_item_id: material_service.id,
          assetable_type: 'StoreMaterialSaleinfoService',
          assetable_id: material_service.id,
          retail_price: 0,
          vip_price: 0,
          price: 0,
          quantity: 1,
          from_customer_asset: true
        };
        Mis.Vues.ServiceItem.items.push(_attrs);
      }else{
        var idx = Mis.Vues.ServiceItem.items.findIndex(function(item){
          return item.from_customer_asset && !item.store_customer_asset_item_id && item.assetable_type == 'StoreMaterialSaleinfoService' && item.assetable_id == id;
        });
        Mis.Vues.ServiceItem.removeItem(idx);
      }
    },

    togglePackageItem: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      if(!(Mis.Vues.VechileInfo.vehicleInfoData && Mis.Vues.VechileInfo.vehicleInfoData.id)){
        target.checked=false;
        $.alert({text: "先选择车辆"});
        return false;
      }
      if(target.checked){
        var package = this.packageCollection.find({id: id});
        var price = package.get('retail_price');
        var _attrs = {
          name: package.get('name'),
          orderable_id: package.get('id'),
          orderable_type: 'StorePackage',
          retail_price: package.get('retail_price'),
          quantity: 1,
          price: price,
        };
        Mis.Vues.PackageItem.items.push(_attrs);
        if(package.get('contains_service')){
          $(target.parentElement.parentElement.parentElement.nextElementSibling).show();
        }
      }else{
        var idx = Mis.Vues.PackageItem.items.findIndex(function(item){
          return item.orderable_type == 'StorePackage' && !item.from_customer_asset && item.orderable_id == id;
        });
        Mis.Vues.PackageItem.removeItem(idx);
      }
    },

    togglePackageServiceItem: function(evt){

      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      var parent_id = parseInt(target.dataset.parentid);
      var package = this.packageCollection.find({id: parent_id});
      var package_service = package.attributes.services.find(function(service){return service.id == id;});
      if(target.checked){
          var _attrs = {
          name: package_service.name,
          orderable_id: package_service.package_itemable_id,
          orderable_type: package_service.package_itemable_type,
          package_type: 'StorePackage',
          package_id: package.id,
          package_item_type: 'StorePackageItem',
          package_item_id: package_service.id,
          assetable_type: package_service.package_itemable_type,
          assetable_id: package_service.package_itemable_id,
          retail_price: package_service.retail_price,
          vip_price: package_service.price,
          price: 0,
          quantity: 1,
          from_customer_asset: true
        };
        Mis.Vues.ServiceItem.items.push(_attrs);
      }else{
        var idx = Mis.Vues.ServiceItem.items.findIndex(function(item){
          return item.from_customer_asset && !item.store_customer_asset_item_id && item.assetable_type == 'StorePackageItem' && item.assetable_id == id;
        });
        Mis.Vues.ServiceItem.removeItem(idx);
      }
    },

    toggleAssetServiceItem: function(evt){
      var target = evt.target
      var asset = this.customer_assets.assets.find(function(asset){return asset.id == target.dataset.assetid});
      var asset_item = asset.items.find(function(item){return item.id == target.dataset.assetitem});
      if(target.checked){
        var _attrs = {
          name: asset_item.name,
          orderable_id: asset_item.orderable_id,
          orderable_type: asset_item.orderable_type,
          store_customer_asset_item_id: asset_item.id,
          retail_price: 0,
          vip_price: 0,
          price: 0,
          quantity: 1,
          from_customer_asset: true
        };
        Mis.Vues.ServiceItem.items.push(_attrs);
      }else{
        var idx = Mis.Vues.ServiceItem.items.findIndex(function(item){
          return item.from_customer_asset && item.store_customer_asset_item_id == asset_item.id;
        });
        Mis.Vues.ServiceItem.removeItem(idx);
      }

    },

    loadMaterials: function(data){
      var _this = this;
      var opt = {
        success:function(collection, array, ajax){
          var html = collection.models.map(function(model,idx){
            var attrs = model.toListAttrs();
            attrs.idx = idx+1;
            return material_tmpl(attrs);
          }).join('');
          $('#js-orderables-materials').html(html);
          _this.checkSelectedMaterials();
          _this.checkSelectedServices();
        },
        error: function(){
          console.log('need a retry?')
        }
      };

      if(data){
        opt.data = data;
      }
      this.materialCollection.fetch(opt);
    },

    loadServices: function(data){
      var _this = this;
      var opt = {
        success:function(collection, array, ajax){
          var html = collection.models.map(function(model,idx){
            var attrs = model.toListAttrs();
            attrs.idx = idx+1;
            return service_tmpl(attrs);
          }).join('');
          $('#js-orderables-services').html(html);
          _this.checkSelectedServices();
        },
        error: function(){
          console.log('need a retry?')
        }
      };
      if(data){
        opt.data = data;
      }
      this.serviceCollection.fetch(opt);
    },

    loadPackages: function(data){
      var _this = this;
      var opt = {
        success:function(collection, array, ajax){
          var html = collection.models.map(function(model,idx){
            var attrs = model.attributes;
            attrs.idx = idx+1;
            return package_tmpl(attrs);
          }).join('');
          $('#js-orderables-packages').html(html);
          _this.checkSelectedPackages();
          _this.checkSelectedServices();
        },
        error: function(){
          console.log('need a retry?')
        }
      };
      if(data){
        opt.data = data;
      }
      this.packageCollection.fetch(opt);
    },

    loadOnce: function(){
      var super_material_categories = $('#super_material_categories').data('categories');
      var service_categories = $('#service_categories').data('categories');
      var store_material_brands = $('#store_material_brands').data('categories')

      this.$el.html(this.template({super_material_categories: super_material_categories,
                                   service_categories: service_categories,
                                   store_material_brands: store_material_brands}));
      this.loadMaterials();
      this.loadPackages();
      this.loadServices();
    },

    show:function(){
      this.$el.show();
    },

    showItem: function(e){
      if(e.target.dataset.target == '.js-orderables-assets'){
        if(Mis.Vues.VechileInfo.vehicleInfoData.id){
          this.hideOtherTableItem();
          this.showAssets(Mis.Vues.VechileInfo.vehicleInfoData.store_customer.id);
          $(e.target.dataset.target).show();
          e.target.className='bg-color-8E81B8 color-fff';
        }else{
          ZhanchuangAlert('请先选择车辆');
        }
      }else{
        this.hideOtherTableItem();
        $(e.target.dataset.target).show();
        e.target.className='bg-color-8E81B8 color-fff';
      }
    },

    showAssets: function(customer_id){

      var url = '/api/crm/customers/' + customer_id + '/assets.json';
      var _this = this;
      if(this.customer_assets && this.customer_assets.id == customer_id){
        $('#js-orderables-assets').show();
      }else{
        $.get(url, function(response){
          var html = assets_tmpl(response.customer);
          $('#js-orderables-assets').html(html);
          _this.customer_assets = response.customer;
          _this.checkSelectedAssetItem();
        });
      }
    },

    checkSelectedAssetItem: function(){
      Mis.Vues.ServiceItem.items.forEach(function(item){
        if(item.from_customer_asset && item.store_customer_asset_item_id){
          var checkbox = $('.js-chose-asset[data-assetitem=' + item.store_customer_asset_item_id + ']');
          var container = checkbox.parents('div.card_item_info');
          checkbox.attr('checked', true);
          container.show();
          container.prev().find('i.js-detail').removeClass('fa-angle-double-down').addClass('fa-angle-double-up');
        }
      });
    },

    hideOtherTableItem: function(){
      $('.order_item').hide();
      $(".order_items_category li").removeClass("bg-color-8E81B8 color-fff");
    },

    toggleDetail: function(evt){
      var target = evt.target;
      if(target.classList.contains('fa-angle-double-down')){
        target.classList.remove('fa-angle-double-down');
        target.classList.add('fa-angle-double-up');
        $(target.parentNode.parentNode.nextElementSibling).show();
      }else{
        target.classList.remove('fa-angle-double-up');
        target.classList.add('fa-angle-double-down');
        $(target.parentNode.parentNode.nextElementSibling).hide();
      }
    }
  })

  Mis.Views.OrderablesView = OrderablesView;
})(window, Backbone, jQuery, Mis)
