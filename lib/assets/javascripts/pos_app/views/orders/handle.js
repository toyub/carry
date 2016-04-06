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
    Mis.current_vehicle = new Mis.Models.StoreVehicle();
    this.orderables_view = new Mis.Views.OrderablesView();
    this.vehicle_situation = new Mis.Vues.VehicleSituation();
    Mis.OrderVueObject(this);
    this.set_vehicle = Mis.SetVehicle();
    this.listenTo(Mis.current_vehicle, 'change', this.afterVehicleFetch)
  },

  afterVehicleFetch: function(){/*FIXME: 这是因为在两个作用域中变量和方法无法互相访问，需要透过 this.set_vehicle 来解决*/
    $('.vehicle-search .js-phone-number').val(Mis.current_vehicle.attributes.store_customer.phone_number);
    $('.vehicle-search .js-customer-name').text(Mis.current_vehicle.attributes.store_customer.full_name);
    $('.fresh').hide();
    $('.frequenter').show();
    $('.customer-tip').hide();
  },

  selectItems: function(el){
    $('div.right_information').children().hide();
    this.orderables_view.show();
  },

  editCustomer: function(){
    var _this = this;
    if(Mis.current_vehicle.id){
      Mis.Views.editCustomer(Mis.current_vehicle.attributes);
    }else{
      $.alert({text: "先选择车辆"});
    }
  },

  editVehicle: function(){
    if(Mis.current_vehicle.id){
      Mis.Views.editVehicle(Mis.current_vehicle.attributes);
    }else{
      $.alert({text: "先选择车辆"});
    }
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

  },

  wasteOrder: function(evt){
    Mis.Views.WasteOrder();
  }
})
