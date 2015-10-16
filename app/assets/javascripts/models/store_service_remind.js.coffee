class Mis.Models.StoreServiceRemind extends Backbone.Model

  urlRoot: '/api/store_service_reminds'

  modelName: 'store_service_remind'

  defaults:
    notice_required: false

  TIMING:
    1: "开单后"
    2: "技师上岗后"
    3: "施工结束后"

  MODE:
    0: "短信"
    1: "微信"

  timingName: ->
    @TIMING[@get 'trigger_timing']

  modeName: ->
    @MODE[@get 'mode']

  modes: ->
    @MODE

  isEnabled: ->
    @get 'enable'

  isNoticeRequired: ->
    @get 'notice_required'
