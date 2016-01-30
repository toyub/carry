(function(win, Backbone, $, Mis){
   var material_tmpl = JST["pos/orders/orderables/material"];
   var service_tmpl  = JST["pos/orders/orderables/service"];
   var package_tmpl  = JST["pos/orders/orderables/package"];
   var OrderablesView = Backbone.View.extend({
    el: ".store-order-item-block",
    template: JST["pos/orders/orderables"],
    events: {
      "click .order_items_category li": "showItem",
      'change input.service-checkbox': 'toggleServiceItem',
      'change input.package-checkbox': 'selectPackage',
      'change input.material-checkbox': 'selectMaterial'
    },
    initialize: function(){
      this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos();
      this.packageCollection = new Mis.Collections.StorePackages();
      this.serviceCollection = new Mis.Collections.StoreServices();
      this.loadOnce();
    },

    toggleServiceItem: function(evt){
      var target = evt.target;
      var id = parseInt(target.dataset.itemid);
      if(target.checked){
        var service = this.serviceCollection.find({id: id});
        var _attrs = {
          name: service.get('name'),
          orderable_id: service.get('id'),
          retail_price: service.get('retail_price'),
          vip_price: service.get('vip_price'),
          quantity: 1
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
        var _attrs = {
          name: material.get('name'),
          speci: material.get('speci'),
          orderable_id: material.get('id'),
          retail_price: material.get('retail_price'),
          vip_price: material.get('vip_price'),
          quantity: 1
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
        var _attrs = {
          name: package.get('name'),
          orderable_id: package.get('id'),
          retail_price: package.get('retail_price'),
          quantity: 1
        };
        Mis.Vues.PackageItem.items.push(_attrs);
      }else{
        Mis.Vues.PackageItem.removeItem({target: { dataset: {orderableid: id}}});
      }
    },

    loadOnce: function(){
      this.$el.html(this.template({}));
      this.materialCollection.fetch({
        success:function(collection, array, ajax){
          var html = collection.models.map(function(model,idx){
            var attrs = model.attributes;
            attrs.idx = idx+1;
            return material_tmpl(attrs);
          }).join('');
          $('#js-orderables-materials').html(html);
        },
        error: function(){
          console.log('need a retry?')
        }
      });

      this.packageCollection.fetch({
        success:function(collection, array, ajax){
          var html = collection.models.map(function(model,idx){
            var attrs = model.attributes;
            attrs.idx = idx+1;
            return package_tmpl(attrs);
          }).join('');
          $('#js-orderables-packages').html(html);
        },
        error: function(){
          console.log('need a retry?')
        }
      });

      this.serviceCollection.fetch({
        success:function(collection, array, ajax){
          var html = collection.models.map(function(model,idx){
            var attrs = model.attributes;
            attrs.idx = idx+1;
            return service_tmpl(attrs);
          }).join('');
          $('#js-orderables-services').html(html);
        },
        error: function(){
          console.log('need a retry?')
        }
      });
    },

    show:function(){
      this.$el.show();
    },

    showItem: function(e){
      this.hideOtherTableItem();
      $(e.target.dataset.target).show();
      e.target.className='bg-color-8E81B8 color-fff';
    },

    hideOtherTableItem: function(){
      $('.order_item').hide();
      $(".order_items_category li").removeClass("bg-color-8E81B8 color-fff");
    }
  })

  Mis.Views.OrderablesView = OrderablesView;
})(window, Backbone, jQuery, Mis)
