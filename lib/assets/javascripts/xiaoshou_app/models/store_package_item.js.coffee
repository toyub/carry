class Mis.Models.StorePackageItem extends Backbone.Model

  urlRoot: '/api/store_package_items'

  modelName: 'store_package_item'

  initialize: (options) ->
    @package_setting = options.package_setting

  defaults:
    package_itemable_type: 'StoreService'
    quantity: 1

  ITEM_TYPE:
    'StoreService': '服务'
    'StoreMaterialSaleinfo': '商品'
    'StoreDepositCard': '储值'

  validation:
    package_itemable_id:
      required: (val, attr, model) ->
        _.contains(['StoreMaterialSaleinfo', 'StoreService'], model.package_itemable_type)
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
        _.contains(['StoreMaterialSaleinfo', 'StoreService'], model.package_itemable_type)
      msg: '次数或数量不能为空'
    price:
      required: true
      msg: '套餐价不能为空'

  packageItemable: ->
    itemable = switch @get('package_itemable_type')
      when 'StoreMaterialSaleinfo' then Mis.materials.get(@get 'package_itemable_id')
      when 'StoreService' then Mis.services.get(@get 'package_itemable_id')
      else @
    itemable ? new Mis.Models.NullObject()

  name: (type = '') ->
    @packageItemable().get 'name'

  retail_price: (type = '') ->
    return '' if type != '' && type != @get('package_itemable_type')
    return @get 'denomination' if @isStoreDepositCard()
    @packageItemable().get 'retail_price'

  cost_price: ->
    @packageItemable().get 'cost_price'

  price: (type = '') ->
    return '' if type != '' && type != @get('package_itemable_type')
    @get 'price'

  quantity: (type = '') ->
    return 1 if type != '' && type != @get('package_itemable_type')
    @get 'quantity'

  category: ->
    @ITEM_TYPE[@get 'package_itemable_type']

  amount: ->
    @price() * (@get('quantity') ? 1)

  regularAmount: ->
    if @get('package_itemable_id')
      @retail_price(@get('package_itemable_type')) * @get('quantity')
    else
      ''

  isStoreService: ->
    @get('package_itemable_type') == 'StoreService'

  isStoreMaterial: ->
    @get('package_itemable_type') == 'StoreMaterialSaleinfo'

  isStoreDepositCard: ->
    @get('package_itemable_type') == 'StoreDepositCard'

  packagedItemAmount: (expect_type)->
    @get('amount')

  packagedItemPrice: (expect_type)->
    parseFloat(@get('amount'))/parseFloat(@get('quantity'))

  discountRate: ->
    rate = (parseFloat(@get('amount'))/parseFloat(@regularAmount()))
    if rate
      (rate*100).toFixed(2)+'%'
    else
      ''
