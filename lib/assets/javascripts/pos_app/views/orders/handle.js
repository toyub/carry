defaultVehicle = {
  id: '',
  license_number: '',
  store_customer: {full_name: '', phone_number: '', property_i18n: '', category_name: '', payment_mode_i18n: ''},
  vehicle_brand:{name: ''}, vehicle_series:{name: ''}, vehicle_model: {name: ''}
};

Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .query_btn": "handlerQueryOrder",
    "blur input[name='license_number']": "setVehicleInfoData",
    "change input[name='phone_number']": "showVehicleButton",
    "click .js-select-items": "selectItems",
    "click .js-draft": "draftOrder",
    'click .js-update-draft': 'updateDraft',
    "click .js-save-and-execute": "saveAndExecute",
    'click .js-update-and-execute': 'updateAndExecute',
    'click .js-update-order': 'updateAndExecute',
    'click .js-edit-customer': 'editCustomer',
    'click .js-edit-vehicle': 'editVehicle',
    "click .trigger-vehicle-form": 'showAddVehicleForm',
    'click .js-waste-order': 'wasteOrder',
    'click .js-vehicle-edit-cancel': 'closeVehicleForm',
    'click .js-customer-edit-cancel': 'closeCustomerForm'
  },
  initialize: function(){
    window.current_customer = {isMembership: false, vehicles: []}

    this.initVehicleSelect();
    this.storeVehicle = new Mis.Models.StoreVehicle(defaultVehicle);
    this.orderables_view = new Mis.Views.OrderablesView();
    this.vehicle_situation = new Mis.Vues.VehicleSituation('#order-situation');
    this.initVueModels();
    this.listenTo(this.storeVehicle, 'change', this.afterFetchVehicle);
  },

  initVueModels: function(){
    var _this =  this;
    Mis.Vues.VechileInfo = new Vue(Mis.Vues.Opts.vehicle);
    Mis.Vues.OrderFormView = new Vue(Mis.Vues.Opts.order_form);
    Mis.Vues.MaterialItem = new Vue(Mis.Vues.Opts.material);
    Mis.Vues.ServiceItem = new Vue(Mis.Vues.Opts.service);
    Mis.Vues.PackageItem = new Vue(Mis.Vues.Opts.package);
    Mis.Vues.VechileInfo.vehicleInfoData = this.storeVehicle.attributes;

    Mis.Vues.MaterialItem.$watch('totalPrice', function(oldVal, newVal){
      Mis.Vues.OrderFormView.amount = Mis.Vues.MaterialItem.totalPrice +
          Mis.Vues.ServiceItem.totalPrice +
          Mis.Vues.PackageItem.totalPrice;
    });

    Mis.Vues.ServiceItem.$watch('totalPrice', function(oldVal, newVal){
      Mis.Vues.OrderFormView.amount = Mis.Vues.MaterialItem.totalPrice +
          Mis.Vues.ServiceItem.totalPrice +
          Mis.Vues.PackageItem.totalPrice;
    });

    Mis.Vues.PackageItem.$watch('totalPrice', function(oldVal, newVal){
      Mis.Vues.OrderFormView.amount = Mis.Vues.MaterialItem.totalPrice +
          Mis.Vues.ServiceItem.totalPrice +
          Mis.Vues.PackageItem.totalPrice;
    });

    Mis.Vues.MaterialItem.$on('remove:item', function(vue_item, vue_remove_fun){
      $('#js-orderables-materials input[data-itemid='+ vue_item.orderable_id +']').removeAttr('checked');
      if(_this.order && vue_item.id){
        var ordered_item = _this.order.materials.items.find(function(item){return item.id == vue_item.id});
        if(ordered_item){
          if(confirm('确定取消订单商品:【'+ ordered_item.name +'】？')){
            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + _this.order.id + '/items/' + ordered_item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
                Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
                $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
                $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            $('#js-orderables-materials input[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
          }
        }else{
          vue_remove_fun.call();
          Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
          $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
          $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
        }
      }else{
        vue_remove_fun.call();
        Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
        $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
        $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
      }
    });

    Mis.Vues.PackageItem.$on('remove:item', function(vue_item, vue_remove_fun){
      $('#js-orderables-packages input[data-itemid='+ vue_item.orderable_id +'].package-checkbox').removeAttr('checked');
      if(_this.order && vue_item.id){
        var ordered_item = _this.order.packages.items.find(function(item){return item.id == vue_item.id});
        if(ordered_item){
          if(confirm('确定取消订单商品:【'+ ordered_item.name +'】？')){
            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + _this.order.id + '/items/' + ordered_item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
                Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
                $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
                $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            $('#js-orderables-packages input[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
          }
        }else{
          vue_remove_fun.call();
          Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
          $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
          $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
        }
      }else{
        vue_remove_fun.call();
        Mis.Vues.ServiceItem.items = Mis.Vues.ServiceItem.items.filter(function(item){return !(item.package_type== vue_item.orderable_type && item.package_id== vue_item.orderable_id);})
        $('#'+vue_item.orderable_type+vue_item.orderable_id).find('input:checked').removeAttr('checked');
        $('#'+vue_item.orderable_type+vue_item.orderable_id).slideUp();
      }
    });

    Mis.Vues.ServiceItem.$on('remove:item', function(vue_item, vue_remove_fun){

      switch(vue_item.orderable_type){
        case 'StoreMaterialSaleinfoService':
          if(vue_item.store_customer_asset_item_id){
            $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').removeAttr('checked');
          }else{
            $('input.js-material-service[data-itemid='+ vue_item.orderable_id +']').removeAttr('checked');
          }
          break;
        case 'StoreService':
          if(vue_item.from_customer_asset){
            if(vue_item.store_customer_asset_item_id){
              $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').removeAttr('checked');
            }else{
              $('input.js-package-service[data-itemid='+ vue_item.orderable_id +']').removeAttr('checked');
            }
          }else{
            $('#js-orderables-services input[data-itemid='+ vue_item.orderable_id +']').removeAttr('checked');
          }
          break;
        default:
          console.log(vue_item.orderable_type)
      }

      if(_this.order && vue_item.id){
        var ordered_item = _this.order.services.items.find(function(item){return item.id == vue_item.id});
        if(ordered_item){
          if(confirm('确定取消订单商品:【'+ ordered_item.name +'】？')){
            $.ajax({
              contentType: 'application/json',
              url: '/api/pos/carts/orders/' + _this.order.id + '/items/' + ordered_item.id,
              type: 'DELETE',
              success: function(){
                vue_remove_fun.call();
              },
              error: function(){
                alert('Failed! Please retry!')
              }
            })
          }else{
            switch(vue_item.orderable_type){
              case 'StoreMaterialSaleinfoService':
                if(vue_item.store_customer_asset_item_id){
                  $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').prop('checked', true);
                }else{
                  $('input.js-material-service[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
                }
                break;
              case 'StoreService':
                if(vue_item.from_customer_asset){
                  if(vue_item.store_customer_asset_item_id){
                    $('input.js-chose-asset[data-assetitem='+ vue_item.store_customer_asset_item_id +']').prop('checked', true);
                  }else{
                    $('input.js-package-service[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
                  }
                }else{
                  $('#js-orderables-services input[data-itemid='+ vue_item.orderable_id +']').prop('checked', true);
                }
                break;
              default:
                console.log(vue_item.orderable_type)
            }

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
    var _this = this;
    if(Mis.Vues.VechileInfo.vehicleInfoData.id){
      Mis.Views.editCustomer(this.storeVehicle.attributes);
    }else{
      $.alert({text: "先选择车辆"});
    }
  },

  closeVehicleForm: function(){
    this.selectItems();
  },

  closeCustomerForm: function(){
    this.selectItems();
  },

  checkPhoneNumber: function(phone_number, func){
    $.ajax({
      type: 'get',
      url: '/api/crm/customers/check',
      contentType: 'application/json',
      data: {phone_number: phone_number},
      success: function(response, status_str, xhr, undef){
        console.log(response);
        func(response);
      },
      error: function(){
        ZhanchuangAlert('Error');
      }
    })
  },

  showAddVehicleForm: function(e){
    var phone_number = $("input[name='phone_number']").val();
    var license_number = $("input[name='license_number']").val();
    var _this = this;
    this.checkPhoneNumber(phone_number, function(response){
        if(response.customer != null) {
          phone_number = response.customer.phone_number
        }
        new Mis.Views.NewCustomerView({customer: response.customer, license_number: license_number, phone_number: phone_number}, _this);
    })
  },

  showVehicleButton: function(){
    var phone_number = $("input[name='phone_number']").val();
    this.checkPhoneNumber(phone_number, function(response){
      if(response.success) {
        $("input[name='phone_number']").addClass("phone_number_already");
        $('.add_new_vehicle').show();
        $('.add_new_customer').hide();
      }else {
        $("input[name='phone_number']").removeClass("phone_number_already");
      }
    })
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

  initVehicleSelect: function(){
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
      }
    });
  },

  afterFetchVehicle: function(){
    window.current_customer = {isMembership: Mis.Vues.VechileInfo.vehicleInfoData.store_customer.membership}
    $('#search-materials').trigger('submit');
    $('#search-services').trigger('submit');
  },

  fetchVehicle: function(){
    var _this = this;
    this.storeVehicle.fetch();
  },

  setVehicleInfoData: function(e){
    var license_number = e.target.value;
    var _this = this;
    if (license_number != "") {
      $.get("/api/store_vehicles/search", {license_number: license_number}, function(data){
        if(data.vehicle_id){
          $('.add_new_vehicle').hide();
          $('.add_new_customer').hide();
          _this.storeVehicle.id = data.vehicle_id;
          _this.fetchVehicle();
        }else{
          _this.storeVehicle = new Mis.Models.StoreVehicle(defaultVehicle);
          Mis.Vues.VechileInfo.$set('vehicleInfoData', _this.storeVehicle.attributes);
          if (!$(".add_new_vehicle").is(":visible")) {
            $('.add_new_vehicle').hide();
            $('.add_new_customer').show();
          }
        }
      })
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
