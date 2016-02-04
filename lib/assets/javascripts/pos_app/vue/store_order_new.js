$(function(){
  Mis.Vues.StoreOrderNew = new Vue({
    el: ".vue-store-order-new",
    data: {
      totalItemsPrice: 0
    },
    computed: {
      totalItemsPrice: function(){
        var price = 0;
        if(Mis.Vues.PackageItem.packageItems.length > 0){
          $.grep(Mis.Vues.PackageItem.packageItems, function(item){
              price += item.quantity * item.retail_price;
          })
        }
        if(Mis.Vues.ServiceItem.serviceItems.length > 0){
          $.grep(Mis.Vues.ServiceItem.serviceItems, function(item){
              price += item.quantity * item.retail_price;
          })
        }
        if(Mis.Vues.MaterialItem.MaterialItems.length > 0){
          $.grep(Mis.Vues.MaterialItem.MaterialItems, function(item){
              price += item.quantity * item.retail_price;
          })
        }
        return price;
      }
    }
  })
})
