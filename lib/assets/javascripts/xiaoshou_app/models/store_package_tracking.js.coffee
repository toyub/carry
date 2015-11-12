class Mis.Models.StorePackageTracking extends Backbone.Model

  urlRoot: ->
    @package_setting.store_package.url() + '/store_package_trackings'

  modelName: 'store_package_tracking'

  initialize: (options) ->
    @package_setting = options.package_setting

  TIMING:
    last_tracking: 0
    after_sale: 1

  TIMING_NAME:
    0: '上次回访后'
    1: '销售后'

  DELAY_UNITS:
    0: '分钟'
    1: '小时'
    2: '天'
    3: '周'
    4: '月'

  TRACKING_MODES:
    0: '短信'
    1: '微信'

  defaluts:
    trigger_timing: @::TIMING.after_sale
    mode: 0
    delay_unit: 0
    notice_required: false

  isTriggeredAfterSale: ->
    @get('trigger_timing').toString() == @TIMING.after_sale.toString()

  timings: ->
    @TIMING

  delayUnits: ->
    @DELAY_UNITS

  content: ->
   s.truncate(@.get('content'), 20)
  trackingModes: ->
    @TRACKING_MODES

  delay: ->
    @get("delay_interval") + @DELAY_UNITS[@get 'delay_unit']

  timingName: ->
    @TIMING_NAME[@get 'trigger_timing']

  modeName: ->
    @TRACKING_MODES[@get 'mode']

  noticeRequired: ->
    @get('notice_required').toString() == 'true'

  clear: ->
    @destroy()
