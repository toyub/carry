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
    'click .js-update-order': 'updateAndExecute',
    'click .js-edit-customer': 'editCustomer',
    'click .js-edit-vehicle': 'editVehicle',
    'click .js-add-vehicle': 'addVehicle'
  },
  initialize: function(){
    window.current_customer = {isMembership: false, vehicles: []}

    this.initSelectInput()
    this.storeVehicle = new Mis.Models.StoreVehicle();
    this.orderables_view = new Mis.Views.OrderablesView();
    this.vehicle_situation = new Mis.Vues.VehicleSituation('#order-situation');
    this.initVueModels();
  },

  initVueModels: function(){
    var _this =  this;
    Mis.Vues.MaterialItem = new Vue(Mis.Vues.Opts.material);
    Mis.Vues.ServiceItem = new Vue(Mis.Vues.Opts.service);
    Mis.Vues.PackageItem = new Vue(Mis.Vues.Opts.package);

    Mis.Vues.MaterialItem.$on('remove:item', function(orderable, vue_remove_fun){
      $('#js-orderables-materials input[data-itemid='+ orderable.orderable_id +']').removeAttr('checked');
      if(_this.order){
        var item = _this.order.materials.items.find(function(item){return item.orderable_id == orderable.orderable_id && item.orderable_type == orderable.orderable_type});
        if(item){
          if(confirm('确定取消订单商品:【'+ item.name +'】？')){

            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + _this.order.id + '/items/' + item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            $('#js-orderables-materials input[data-itemid='+ orderable.orderable_id +']').prop('checked', true);
          }
        }else{
          vue_remove_fun.call();
        }
      }else{
        vue_remove_fun.call();
      }
    });

    Mis.Vues.PackageItem.$on('remove:item', function(orderable, vue_remove_fun){
      $('#js-orderables-packages input[data-itemid='+ orderable.orderable_id +']').removeAttr('checked');
      if(_this.order){
        var item = _this.order.packages.items.find(function(item){return item.orderable_id == orderable.orderable_id && item.orderable_type == orderable.orderable_type});
        if(item){
          if(confirm('确定取消订单商品:【'+ item.name +'】？')){

            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + _this.order.id + '/items/' + item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            $('#js-orderables-packages input[data-itemid='+ orderable.orderable_id +']').prop('checked', true);
          }
        }else{
          vue_remove_fun.call();
        }
      }else{
        vue_remove_fun.call();
      }
    });

    Mis.Vues.ServiceItem.$on('remove:item', function(orderable, vue_remove_fun){
      $('#js-orderables-services input[data-itemid='+ orderable.orderable_id +']').removeAttr('checked');
      if(_this.order){
        var item = _this.order.services.items.find(function(item){return item.orderable_id == orderable.orderable_id && item.orderable_type == orderable.orderable_type});
        if(item){
          if(confirm('确定取消订单商品:【'+ item.name +'】？')){

            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + _this.order.id + '/items/' + item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            $('#js-orderables-services input[data-itemid='+ orderable.orderable_id +']').prop('checked', true);
          }
        }else{
          vue_remove_fun.call();
        }
      }else{
        vue_remove_fun.call();
      }
    });
  },

  selectItems: function(el){
    $('div.right_information').children().hide();
    this.orderables_view.show();
  },

  editCustomer: function(){
    if(Mis.Vues.VechileInfo.vehicleInfoData.id){
      Mis.Views.editCustomer(this.storeVehicle.attributes);
    }else{
      $.alert({text: "先选择车辆"});
    }
  },

  addVehicle: function(){
    form_dialog(JST["pos/orders/vehicle/form"]())
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
        }
      },
      footer: {items: [{text: 'Add State', action: 'alert(23)'}]}
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
      materials: Mis.Vues.MaterialItem.items,
      packages: Mis.Vues.PackageItem.items,
      services: Mis.Vues.ServiceItem.items
    };
  },

  draftOrder: function(e){
    var target = e.target;
    var vehicle_id = $("#store_vehicle_id").val();
    if(!vehicle_id){
      $.alert({text: "请先选择车辆!"});
      return false;
    }

    var items_length = Mis.Vues.MaterialItem.items.length +
                       Mis.Vues.PackageItem.items.length +
                       Mis.Vues.ServiceItem.items.length;

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
      $.alert({text: "订单保存为草稿!"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "保存失败,请重试！" + xhr.responseJSON.error});
    })
  },
  updateDraft: function(){
    var items_length = Mis.Vues.MaterialItem.items.length +
                       Mis.Vues.PackageItem.items.length +
                       Mis.Vues.ServiceItem.items.length;

    if(items_length < 1){
      $.alert({text: "没有选择任何产品或服务，无法保存!"});
      return false;
    }

    var storeOrderParams = this.orderParams();
    var url = '/api/store_orders/' + this.order.id + '/update_draft';
    
    $.ajax({
        method: 'PUT',
        url: url,
        contentType: 'application/json',
        data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $.alert({text: "更新草稿成功!"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "订单保存失败！" + xhr.responseJSON.error});
    });
  },
  saveAndExecute: function(e){
    var target = e.target;
    var vehicle_id = $("#store_vehicle_id").val();
    if(!vehicle_id){
      $.alert({text: "请先选择车辆!"});
      return false;
    }

    var items_length = Mis.Vues.MaterialItem.items.length +
                       Mis.Vues.PackageItem.items.length +
                       Mis.Vues.ServiceItem.items.length;

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

  updateAndExecute: function(){
    var items_length = Mis.Vues.MaterialItem.items.length +
                       Mis.Vues.PackageItem.items.length +
                       Mis.Vues.ServiceItem.items.length;

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
    }).done(function(response){
      $.alert({text: "订单保存成功！"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "订单保存失败！" + xhr.responseJSON.error});
    });

  }
})
