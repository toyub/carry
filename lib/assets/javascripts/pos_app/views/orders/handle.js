Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .js-select-items": "selectItems",
    "click .js-draft": "draftOrder",
    'click .js-update-draft': 'updateDraft',
    "click .js-save-and-execute": "saveAndExecute",
    'click .js-update-and-execute': 'updateAndExecute',
    'click .js-update-order': 'updateAndExecute',
    'click .js-edit-customer': 'editCustomer',
    'click .js-edit-vehicle': 'editVehicle',
    'click .js-waste-order': 'wasteOrder'
  },
  initialize: function(){
    this.orderables_view = new Mis.Views.OrderablesView();
    this.vehicle_situation = new Mis.Vues.VehicleSituation();
    this.vehicles_controller = $$MIS.getVehiclesControllerInstance();
    Mis.OrderVueObject(this);

    this.listenTo(this.vehicles_controller, 'vehiclechange', this.vehicleChange);
    this.listenTo(this.vehicles_controller, 'customerchange', this.customerChange);
    this.listenTo(this.orderables_view, 'choseitem', this.beginToOrder)
  },

  editOrder: function(){
    this.vehicles_controller.editOrderInit(this.order.store_vehicle_id);
  },

  beginToOrder: function(){
    this.vehicles_controller.lock();/**TIP: this will lock & disable the search function, if the operator chose something to order **/
  },

  saveVehicleBeforeOrder: function(callback){
    var _this = this;
    this.vehicles_controller.save_new_vehicle(function(){
      callback.call(_this);
    });
  },

  selectItems: function(el){
    $('div.right_information').children().hide();
    this.orderables_view.show();
  },

  vehicleChange: function(vehicle, customer){/*reset the vehicle and customer, case we need it to calcute*/
    if(!vehicle && !customer){/* reset and clear all things */
      this.orderables_view.vehicle = null;
      this.orderables_view.customer = null;
      $("#store_vehicle_id").val('');
    }else if(!!vehicle && !customer){

    }else if(!vehicle && !!customer){

    }else{/** existing vehicle and customer **/
      this.orderables_view.vehicle = vehicle;
      this.orderables_view.customer = customer;
      if(vehicle.id){
        $("#store_vehicle_id").val(vehicle.id);
      }else{
        $("#store_vehicle_id").val('');
      }
    }
    this.vehicles_controller.shwoVehicleEssentials();
  },

  customerChange: function(vehicle, customer){
    if(!vehicle && !customer){
      this.orderables_view.vehicle = null;
      this.orderables_view.customer = null;
      $("#store_vehicle_id").val('');
    }else if(!!vehicle && !customer){

    }else if(!vehicle && !!customer){

    }else{
      this.orderables_view.vehicle = vehicle;
      this.orderables_view.customer = customer;
      if(vehicle.id){
        $("#store_vehicle_id").val(vehicle.id);
      }else{
        $("#store_vehicle_id").val('');
      }
    }
    this.vehicles_controller.shwoVehicleEssentials();
  },

  editCustomer: function(){
    this.vehicles_controller.editCustomer();
  },

  editVehicle: function(){
    this.vehicles_controller.editVehicle();
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

  loadingPageShow: function(){
    $(".btn").prop('disabled', true);
    $('#loading-position').show();
  },

  draftOrder: function(e){
    var vehicle_id = $("#store_vehicle_id").val();
    if(!vehicle_id){
      if(e && e.target){/* trigger by user in click save button */
        this.saveVehicleBeforeOrder(this.draftOrder); /**/
      }else{
        console.log('no!')
      }
      return false;
    }

    var items_length = Mis.Vues.MaterialItem.items.length +
                       Mis.Vues.PackageItem.items.length +
                       Mis.Vues.ServiceItem.items.length;

    if(items_length < 1){
      $.alert({text: "没有选择任何产品或服务，无法保存!"});
      return false;
    }
    this.loadingPageShow();

    var storeOrderParams = this.orderParams();

    $.ajax({
      method: "POST",
      url: '/api/store_orders/draft',
      contentType: 'application/json',
      data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $('#loading-position').hide();
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
    this.loadingPageShow();

    var storeOrderParams = this.orderParams();
    var url = '/api/store_orders/' + this.order.id + '/update_draft';

    $.ajax({
        method: 'PUT',
        url: url,
        contentType: 'application/json',
        data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $('#loading-position').hide();
      $.alert({text: "更新草稿成功!"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "订单保存失败！" + xhr.responseJSON.error});
    });
  },

  saveAndExecute: function(e){
    var vehicle_id = $("#store_vehicle_id").val();
    if(!vehicle_id){
      if(e && e.target){/* trigger by user in click save button */
        this.saveVehicleBeforeOrder(this.saveAndExecute); /**/
      }else{
        console.log('no!')
      }
      return false;
    }

    var items_length = Mis.Vues.MaterialItem.items.length +
                       Mis.Vues.PackageItem.items.length +
                       Mis.Vues.ServiceItem.items.length;

    if(items_length < 1){
      $.alert({text: "没有选择任何产品或服务，无法保存!"});
      return false;
    }
    this.loadingPageShow();

    var storeOrderParams = this.orderParams();

    $.ajax({
      method: "POST",
      url: '/api/store_orders',
      contentType: 'application/json',
      data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $('#loading-position').hide();
      $.alert({text: "订单保存成功！"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $(".btn").prop('disabled', false);
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
    this.loadingPageShow();

    var storeOrderParams = this.orderParams();
    var url = '/api/store_orders/' + this.order.id;

    $.ajax({
        method: 'PUT',
        url: url,
        contentType: 'application/json',
        data: JSON.stringify(storeOrderParams)
    }).done(function(response){
      $('#loading-position').hide();
      $.alert({text: "订单保存成功！"});
      setTimeout(function(){
        window.location.replace('/pos/store_orders/'+response.order.id+'/edit');
      }, 1500);
    }).fail(function(xhr, status_str, status_text){
      $.alert({text: "订单保存失败！" + xhr.responseJSON.error});
    });

  },

  wasteOrder: function(evt){
    Mis.Views.WasteOrder();
  }
})
