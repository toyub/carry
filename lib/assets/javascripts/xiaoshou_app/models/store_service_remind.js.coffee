class Mis.Models.StoreServiceRemind extends Backbone.Model

  modelName: 'store_service_remind'

  urlRoot: ->
    Mis.services.get(@get 'store_service_id').url() + '/store_service_reminds'

  defaults:
    notice_required: false

  TIMING:
    ordered: "开单后"
    started: "技师上岗后"
    finished: "施工结束后"

  MODE:
    sms: "短信"
    wechat: "微信"

  timingName: ->
    @TIMING[@get 'trigger_timing']

  modeName: ->
    @MODE[@get 'mode']

  modes: ->
    @MODE

  isEnabled: ->
    String(@get 'enable') == 'true'

  isNoticeRequired: ->
    String(@get 'notice_required') == 'true'

  serviceName: ->
    Mis.services.get(@get 'store_service_id').get 'name'
