class Mis.Models.StoreServiceSetting extends Backbone.Model

  urlRoot: '/api/store_service_settings'

  modelName: 'store_service_setting'

  url: ->
    @store_service.url() + '/store_service_settings'

  SETTING_TYPE:
    regular: 0
    workflow: 1

  defaults:
    setting_type: @::SETTING_TYPE.regular

  initialize: ->
    @parseStoreService()
    @parseWorkflows()
    @initWorkstations()

  initWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations()

  parseStoreService: ->
    @store_service = @get 'store_service'

  parseWorkflows: ->
    @workflows = new Mis.Collections.StoreServiceWorkflows(@get 'workflows')

  isRegular: ->
    parseInt(@get 'setting_type') == @SETTING_TYPE.regular

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    if @isRegular()
      workstation_attrs = {store_workstation_ids: @workstations.workstation_ids()}
      json.workflows_attributes = _.extend @omit(['setting_type', 'store_service', 'workflows']), workstation_attrs
    else
      json.workflows_attributes = @workflows.map(
        (workflow) ->
          workflow.attributes
      )
    hashWithRoot[@modelName] = json
    hashWithRoot
