class Mis.Models.StoreServiceRemind extends Backbone.Model

  modelName: 'store_service_remind'

  urlRoot: ->
    window.StoreServices.get(@get 'store_service_id').url() + '/store_service_reminds'

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
    String(@get 'enable') == 'true'

  isNoticeRequired: ->
    String(@get 'notice_required') == 'true'

  serviceName: ->
    window.StoreServices.get(@get 'store_service_id').get 'name'
