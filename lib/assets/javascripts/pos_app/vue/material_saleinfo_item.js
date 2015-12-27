$(function(){

  Mis.Vues.MaterialSaleinfoItem = new Vue({
    el: ".material-saleinfo-table-items",
    data: {
      materialSaleinfoItems: [],
    },
    methods: {
      removeItem: function(e){
        var id = $(e.target).data("item-id");
        var _this = this;
        $.grep(this.materialSaleinfoItems, function(e){
          if(e.id == id){
            _this.materialSaleinfoItems.pop(e);
          }
        })
      }
    },
    computed: {
      totalPrice: function(){
        var price = 0;
        if(this.materialSaleinfoItems.length > 0){
          $.grep(this.materialSaleinfoItems, function(item){
            console.log(item.quantity);
            console.log(item.retail_price);
            price += item.quantity * item.retail_price;
          })
        }
        return price;
      }
    }
  })
})
