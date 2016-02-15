(function(win, Backbone, $, Mis){
   var material_tmpl = JST["pos/orders/orderables/material"];
   var service_tmpl  = JST["pos/orders/orderables/service"];
   var package_tmpl  = JST["pos/orders/orderables/package"];
   var assets_tmpl = JST["pos/orders/orderables/asset"];
   var cached_sub_categories = {};

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
      'change input.package-checkbox': 'selectPackage',
      'change input.material-checkbox': 'selectMaterial',
      'submit #search-materials': 'searchMaterials',
      'submit #search-services': 'searchServices',
      'submit #search-packages': 'searchPackages',
      'change [name="store_material_root_category_id"]': 'showSubcategories',
      'click .js-orderables-assets i.js-detail': 'toggleDetail',
      'change .js-orderables-assets .js-chose-asset': 'choseAsset'
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
      var service_items_ids = Mis.Vues.ServiceItem.items.map(function(item){return item.orderable_id});
      service_items_ids.forEach(function(orderable_id, idx){
        $('#js-orderables-services input[data-itemid='+ orderable_id +']').attr('checked', true);
      });
    },

    checkSelectedMaterials: function(){
      var material_items_ids = Mis.Vues.MaterialItem.items.map(function(item){return item.orderable_id});
      material_items_ids.forEach(function(orderable_id, idx){
        $('#js-orderables-materials input[data-itemid='+ orderable_id +']').attr('checked', true);
      });
      
    },

    checkSelectedPackages: function(){
      var package_items_ids = Mis.Vues.PackageItem.items.map(function(item){return item.orderable_id});
      package_items_ids.forEach(function(orderable_id, idx){
        $('#js-orderables-packages input[data-itemid='+ orderable_id +']').attr('checked', true);
      });
    },

    toggleServiceItem: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      if(target.checked){
        var service = this.serviceCollection.find({id: id});
        var price = service.get('retail_price') /*TODO: here the price */
        var _attrs = {
          name: service.get('name'),
          orderable_id: service.get('id'),
          retail_price: service.get('retail_price'),
          vip_price: service.get('vip_price'),
          quantity: 1,
          price: price
        };
        Mis.Vues.ServiceItem.items.push(_attrs);
      }else{
        Mis.Vues.ServiceItem.removeItem({target: { dataset: {orderableid: id}}});
      }
    },

    selectMaterial: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      if(target.checked){
        var material = this.materialCollection.find({id: id});
        var price = material.get('retail_price') /*TODO: here the price */
        var _attrs = {
          name: material.get('name'),
          speci: material.get('speci'),
          orderable_id: material.get('id'),
          retail_price: material.get('retail_price'),
          vip_price: material.get('vip_price'),
          quantity: 1,
          price: price
        }
        Mis.Vues.MaterialItem.items.push(_attrs);
      }else{
        Mis.Vues.MaterialItem.removeItem({target: { dataset: {orderableid: id}}});
      }
    },

    selectPackage: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      if(target.checked){
        var package = this.packageCollection.find({id: id});
        var price = package.get('retail_price') /*TODO: here the price */
        var _attrs = {
          name: package.get('name'),
          orderable_id: package.get('id'),
          retail_price: package.get('retail_price'),
          quantity: 1,
          price: price,
        };
        Mis.Vues.PackageItem.items.push(_attrs);
      }else{
        Mis.Vues.PackageItem.removeItem({target: { dataset: {orderableid: id}}});
      }
    },

    loadMaterials: function(data){
      var _this = this;
      var opt = {
        success:function(collection, array, ajax){
          var html = collection.models.map(function(model,idx){
            var attrs = model.attributes;
            attrs.idx = idx+1;
            return material_tmpl(attrs);
          }).join('');
          $('#js-orderables-materials').html(html);
          _this.checkSelectedMaterials();
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
            var attrs = model.attributes;
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
          });
      }
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
    },

    choseAsset: function(evt){
      var target = evt.target
      if(target.checked){
        var asset = this.customer_assets.assets.find(function(asset){return asset.id == target.dataset.assetid});
        var item = asset.items.find(function(item){return item.id == target.dataset.assetitem});
        var _attrs = {
          name: item.name,
          orderable_id: item.id,
          orderable_type: 'StoreCustomerAssetItem',
          retail_price: 22,
          vip_price: 33,
          quantity: 1,
          from_customer_asset: true,
          price: 0
        };
        Mis.Vues.ServiceItem.items.push(_attrs);
      }else{
        var idx = Mis.Vues.ServiceItem.items.findIndex(function(item){
          return item.orderable_type == 'StoreCustomerAssetItem' && item.orderable_id == target.dataset.assetitem;
        });
        Mis.Vues.ServiceItem.items.splice(idx, 1);
      }
      
    }
  })

  Mis.Views.OrderablesView = OrderablesView;
})(window, Backbone, jQuery, Mis)
