class Mis.Models.StorePackageSetting extends Backbone.Model

  urlRoot: '/api/store_package_settings'

  modelName: 'store_package_setting'

  url: ->
    @store_package.url() + '/store_package_settings'

  RANGE:
    only: 0
    all: 1

  PAYMENT_MODE:
    password: 0
    message: 1

  PERIOD_UNIT:
    0: '年'
    1: '月'
    2: '日'

  defaults:
    apply_range: @::RANGE.only
    period_enable: true
    expired_notice_required: false

  initialize: (options) ->
    @store_package = options.store_package

    @parseItems()

  period_unit_name: ->
    @PERIOD_UNIT[@get('period_unit')]

  periodUnits: ->
    @PERIOD_UNIT

  periodEnable: ->
    String(@get 'period_enable') == 'true'

  noticeRequired: ->
    String(@get 'expired_notice_required') == 'true'

  applyAll: ->
    String(@get 'apply_range') == String(@RANGE.all)

  passwordAuth: ->
    String(@get 'payment_mode') == String(@PAYMENT_MODE.password)

  parseItems: ->
    @items = new Mis.Collections.StorePackageItems(@get 'items')

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    json.items_attributes = @items.map(
      (item) ->
        item.attributes
    )
    hashWithRoot[@modelName] = json
    hashWithRoot
