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

  packageItemable: ->
    itemable = switch @get('package_itemable_type')
      when 'StoreMaterial' then window.Store.materials.get(@get 'package_itemable_id')
      when 'StoreService' then window.StoreServices.get(@get 'package_itemable_id')
      else @
    itemable ? new Mis.Models.NullObject()

  name: (type = '') ->
    return '' if type != '' && type != @get('package_itemable_type')
    @packageItemable().get 'name'

  retail_price: (type = '') ->
    return '' if type != '' && type != @get('package_itemable_type')
    return @get 'denomination' if @isStoreDepositCard()
    @packageItemable().get 'price'

  price: (type = '') ->
    return '' if type != '' && type != @get('package_itemable_type')
    @get 'price'

  quantity: (type = '') ->
    return '' if type != '' && type != @get('package_itemable_type')
    @get 'quantity'

  category: ->
    @ITEM_TYPE[@get 'package_itemable_type']

  amount: ->
    @price() * (@get('quantity') ? 1)

  regularAmount: ->
    @retail_price() * (@get('quantity') ? 1)

  isStoreService: ->
    @get('package_itemable_type') == 'StoreService'

  isStoreMaterial: ->
    @get('package_itemable_type') == 'StoreMaterial'

  isStoreDepositCard: ->
    @get('package_itemable_type') == 'StoreDepositCard'