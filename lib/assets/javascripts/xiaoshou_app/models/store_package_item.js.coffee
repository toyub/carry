class Mis.Models.StorePackageItem extends Backbone.Model

  urlRoot: '/api/store_package_items'

  modelName: 'store_package_item'

  initialize: (options) ->
    @package_setting = options.package_setting

  defaults:
    package_itemable_type: 'StoreService'

  ITEM_TYPE:
    'StoreService': '服务'
    'StoreMaterial': '商品'
    'StoreDepositCard': '储值'

  validation:
    package_itemable_id:
      required: (val, attr, model) ->
        _.includes(['StoreMaterial', 'StoreService'], model.package_itemable_type)
      msg: '项目名称不能为空'
    name:
      required: (val, attr, model) ->
        'StoreDepositCard' == model.package_itemable_type
      msg: '储值名称不能为空'
    denomination:
      required: (val, attr, model) ->
        'StoreDepositCard' == model.package_itemable_type
      msg: '面额不能为空'
    quantity:
      required: (val, attr, model) ->
        _.includes(['StoreMaterial', 'StoreService'], model.package_itemable_type)
      msg: '次数或数量不能为空'
    price:
      required: true
      msg: '套餐价不能为空'

  name: ->
    switch @get('package_itemable_type')
      when 'StoreMaterial' then window.Store.materials.get(@get 'package_itemable_id').get 'name'
      when 'StoreService' then window.StoreServices.get(@get 'package_itemable_id').get 'name'
      else @get 'name'

  retail_price: ->
    switch @get('package_itemable_type')
      when 'StoreMaterial' then window.Store.materials.get(@get 'package_itemable_id').get 'cost_price'
      when 'StoreService' then window.StoreServices.get(@get 'package_itemable_id').get 'retail_price'
      else @get 'price'

  price: ->
    switch @get('package_itemable_type')
      when 'StoreMaterial', 'StoreService' then @get 'price'
      else @get 'denomination'

  category: ->
    @ITEM_TYPE[@get 'package_itemable_type']

  amount: ->
    @price() * (@get('quantity') ? 1)

  isStoreService: ->
    @get 'package_itemable_type' == 'StoreService'

  isStoreMaterial: ->
    @get 'package_itemable_type' == 'StoreMaterial'

  isStoreDepositCard: ->
    @get 'package_itemable_type' == 'StoreDepositCard'
