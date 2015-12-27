$(function(){

  Mis.Vues.MaterialSaleinfoItem = new Vue({
    el: ".material-saleinfo-table-items",
    data: {
      materialSaleinfoItems: []
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
    }
  })

})
