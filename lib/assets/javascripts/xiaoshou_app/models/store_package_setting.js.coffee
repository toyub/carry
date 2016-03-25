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
    period: 0

  initialize: (options) ->
    @store_package = options.store_package
    @on('change:items', @parseItems)

    @parseItems()

  validPeriod: ->
    unless String(@get 'period') == '0'
      @get('period') + @period_unit_name()

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

  amount: ->
    @items.map((item) ->
      item.amount()
    ).reduce((sum, amount) ->
      sum + amount
    ,0)

  regularAmount: ->
    @items.map((item) ->
      item.regularAmount()
    ).reduce((sum, amount) ->
      sum + amount
    ,0)

  discountRate: ->
    (@amount()/@regularAmount()).toFixed(2)

  commissionName: ->
    commission = Mis.commissions.find(
      (c) =>
        String(c.id) == String(@get("store_commission_template_id"))
    )
    commission.get("name") if commission


  toJSON: ->
    hashWithRoot = {}
    json = _.omit(_.clone(@attributes), "store_package")
    json.items_attributes = @items.map(
      (item) ->
        _.omit item.attributes, "package_setting"
    )
    hashWithRoot[@modelName] = json
    hashWithRoot
