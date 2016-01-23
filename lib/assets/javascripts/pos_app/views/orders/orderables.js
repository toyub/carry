(function(win, Backbone, $, Mis){
   var material_tmpl = JST["pos/orders/orderables/material"];
   var service_tmpl  = JST["pos/orders/orderables/service"];
   var package_tmpl  = JST["pos/orders/orderables/package"];
   var OrderablesView = Backbone.View.extend({
    el: ".store-order-item-block",
    template: JST["pos/orders/orderables"],
    events: {
      "click .js-material-saleinfo-checkbox": "setMaterialSaleInfoData",
      "click .js-package-checkbox": "setPackageData",
      "click .js-service-checkbox": "setServiceData",
      "click .order_items_category li": "showItem"
    },
    initialize: function(){
      this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos;
      this.packageCollection = new Mis.Collections.StorePackages;
      this.serviceCollection = new Mis.Collections.StoreServices;
      this.loadOnce();
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
