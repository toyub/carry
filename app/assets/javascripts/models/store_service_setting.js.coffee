class Mis.Models.StoreServiceSetting extends Backbone.Model

  urlRoot: '/api/store_service_settings'

  modelName: 'store_service_setting'

  url: ->
    @store_service.url() + '/store_service_settings'

  SETTING_TYPE:
    regular: 0
    workflow: 1

  POSITION_MODE:
    auto: 1
    app: 2

  defaults:
    setting_type: @::SETTING_TYPE.regular

  initialize: ->
    @parseStoreService()
    @parseWorkflows()
    @initWorkstations()

    @on('change:workflows', @parseWorkflows, @)

  initWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations()

  parseStoreService: ->
    @store_service = @get 'store_service'

  parseWorkflows: ->
    @workflows = new Mis.Collections.StoreServiceWorkflows(@get 'workflows')

  isRegular: ->
    parseInt(@get 'setting_type') == @SETTING_TYPE.regular

  isAppPosition: ->
    parseInt(@get('position_mode')) == @POSITION_MODE.app

  isLimitedEngineerCount: ->
    @get 'engineer_count_enable'

  isLimitedEngineerLevel: ->
    @get 'engineer_level_enable'

  standardTimeEnable: ->
    @get 'standard_time_enable'

  bufferingTimeEnable: ->
    @get 'buffering_time_enable'

  nominatedWorkstation: ->
    @get 'nominated_workstation'

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    if @isRegular()
      workstation_attrs = {store_workstation_ids: @workstations.workstation_ids()}
      json.workflows_attributes = _.extend @omit(['setting_type', 'store_service', 'workflows']), workstation_attrs
    else
      json.workflows_attributes = @workflows.map(
        (workflow) ->
          workstation_attrs = {store_workstation_ids: workflow.workstations.workstation_ids()}
          _.extend workflow.attributes, workstation_attrs
      )
    hashWithRoot[@modelName] = json
    hashWithRoot
