Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .query_btn": "handlerQueryOrder",
    "change select[name='license-number']": "setVehicleInfoData",
    "click .js-select-items": "selectItems",
    "click .js-draft": "draftOrder",
    'click .js-update-draft': 'updateDraft',
    "click .js-save-and-execute": "saveAndExecute",
    'click .js-update-and-execute': 'updateAndExecute',
    'click .js-update-order': 'updateOrder',
    'click .js-edit-customer': 'editCustomer',
    'click .js-edit-vehicle': 'editVehicle'
  },
  initialize: function(){
    this.initSelectInput()
    this.storeVehicle = new Mis.Models.StoreVehicle();
    this.OrderablesView = new Mis.Views.OrderablesView();
    this.vehicle_situation = new Mis.Vues.VehicleSituation('#order-situation');
    Mis.Vues.MaterialSaleinfoItem = new Vue(Mis.Vues.Opts.material);
    Mis.Vues.ServiceItem = new Vue(Mis.Vues.Opts.service);
    Mis.Vues.PackageItem = new Vue(Mis.Vues.Opts.package);
  },

  selectItems: function(el){
    $('div.right_information').children().hide();
    this.OrderablesView.show();
  },

  editCustomer: function(){
    if(Mis.Vues.VechileInfo.vehicleInfoData.id){
      Mis.Views.editCustomer(this.storeVehicle.attributes);
    }else{
      $.alert({text: "先选择车辆"});
    }
  },

  editVehicle: function(){
    if(Mis.Vues.VechileInfo.vehicleInfoData.id){
      Mis.Views.editVehicle(this.storeVehicle.attributes);
    }else{
      $.alert({text: "先选择车辆"});
    }
  },

  handlerQueryOrder: function(){
    console.log("click the query order btn");
  },

  initSelectInput: function(){
    $(".js-store-vehicle-license-number-input").select2({
      language: "zh-CN",
      ajax: {
        url: "/api/store_vehicles/search",
        dataType: "json",
        data: function(params){
          return {
            q: params.term
          }
        },
        processResults: function(data, params){
          params.page = params.page || 1;

          return {
            results: data.items,
            pagination: {
              more: (params.page * 30) < data.total_count
            }
          };
        },
      }
    });
  },

  setVehicleInfoData: function(e){
    var StoreVehicleId = e.target.value;
    var _this = this;
    this.storeVehicle.id = StoreVehicleId;

    this.storeVehicle.fetch({
      success: function(){
        Mis.Vues.VechileInfo.vehicleInfoData = _this.storeVehicle.attributes;
      }
    });
  },

  orderParams: function(){
    var vehicle_id = $("#store_vehicle_id").val();
    return {
      vehicle_id: vehicle_id,
      situation: this.vehicle_situation.get_situation(),
      materials: Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems,
      packages: Mis.Vues.PackageItem.packageItems,
      services: Mis.Vues.ServiceItem.serviceItems
    };
  },

  draftOrder: function(e){
    var target = e.target;
    var vehicle_id = $("#store_vehicle_id").val();
    if(!vehicle_id){
      $.alert({text: "请先选择车辆!"});
      return false;
    }

    var items_length = Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems.length +
                       Mis.Vues.PackageItem.packageItems.length +
                       Mis.Vues.ServiceItem.serviceItems.length;

    if(items_length < 1){
      $.alert({text: "没有选择任何产品或服务，无法保存!"});
      return false;
    }

    var storeOrderParams = this.orderParams();

    $.ajax({
      method: "POST",
      url: '/api/store_orders/draft',
      contentType: 'application/json',
      data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $.alert({text: "订单保存成功！"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "订单保存失败！" + xhr.responseJSON.error});
    })
  },
  updateDraft: function(){},
  saveAndExecute: function(e){
    var target = e.target;
    var vehicle_id = $("#store_vehicle_id").val();
    if(!vehicle_id){
      $.alert({text: "请先选择车辆!"});
      return false;
    }

    var items_length = Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems.length +
                       Mis.Vues.PackageItem.packageItems.length +
                       Mis.Vues.ServiceItem.serviceItems.length;

    if(items_length < 1){
      $.alert({text: "没有选择任何产品或服务，无法保存!"});
      return false;
    }

    var storeOrderParams = this.orderParams();

    $.ajax({
      method: "POST",
      url: '/api/store_orders',
      contentType: 'application/json',
      data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $.alert({text: "订单保存成功！"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "订单保存失败！" + xhr.responseJSON.error});
    })
  },
  updateAndExecute: function(){},
  updateOrder: function(){},

  saveOrder: function(e){
    var target = e.target;
    var vehicle_id = $("#store_vehicle_id").val();
    if(!vehicle_id){
      $.alert({text: "请先选择车辆!"});
      return false;
    }

    var items_length = Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems.length +
                       Mis.Vues.PackageItem.packageItems.length +
                       Mis.Vues.ServiceItem.serviceItems.length;

    if(items_length < 1){
      $.alert({text: "没有选择任何产品或服务，无法保存!"});
      return false;
    }

    var storeOrderParams = this.orderParams();

    $.ajax({
      method: "POST",
      url: '/api/store_orders',
      contentType: 'application/json',
      data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $.alert({text: "订单保存成功！"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "订单保存失败！" + xhr.responseJSON.error});
    })

  },

  updateOrder: function(){
    var items_length = Mis.Vues.MaterialSaleinfoItem.materialSaleinfoItems.length +
                       Mis.Vues.PackageItem.packageItems.length +
                       Mis.Vues.ServiceItem.serviceItems.length;

    if(items_length < 1){
      $.alert({text: "没有选择任何产品或服务，无法保存!"});
      return false;
    }

    var storeOrderParams = this.orderParams();
    var url = '/api/store_orders/' + this.order.id;
    
    $.ajax({
        method: 'PUT',
        url: url,
        contentType: 'application/json',
        data: JSON.stringify(storeOrderParams)
    });

  }
})