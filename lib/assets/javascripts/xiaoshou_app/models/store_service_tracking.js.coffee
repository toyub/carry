class Mis.Models.StoreServiceTracking extends Backbone.Model

  modelName: 'store_service_tracking'

  urlRoot: ->
    @store_service.url() + '/store_service_trackings'

  initialize: (attrs, options) ->
    super(attrs)
    @store_service = options.store_service

  defaults:
    notice_required: false
    mode: 0
    trigger_timing: 0
    delay_unit: 0

  TIMING:
    0: "销售后"
    1: "上次回访后"

  MODE:
    0: "短信"
    1: "微信"

  DELAY_UNITS:
    0: "分钟"
    1: "小时"
    2: "天"
    3: "周"
    4: "月"

  modes: ->
    @MODE

  timings: ->
    @TIMING

  delayUnits: ->
    @DELAY_UNITS

  isNoticeRequired: ->
    String(@get 'notice_required') == 'true'

  timingName: ->
    @TIMING[@get 'trigger_timing']

  modeName: ->
    @MODE[@get 'mode']

  delay: ->
    @get("delay_interval") + @DELAY_UNITS[@get 'delay_unit']

  clear: ->
    @destroy()
