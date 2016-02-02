class Mis.Models.StoreServiceWorkflow extends Backbone.Model

  urlRoot: '/api/store_service_workflows'

  modelName: 'store_service_workflow'

  initialize: ->
    @initWorkstations()
    console.log @get "engineer_level"

  defaults:
    engineer_count_enable: true

  clear: ->
    @destroy(wait: true)

  workstationName: ->
    if @get("nominated_workstation")
      @workstations.map(
        (w) ->
          w.get "name"
      ).join("，").substring(0,10)
    else
      "不限"

  initWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations()
    Mis.store.workstations.each(
      (w) =>
        @workstations.add w if _.contains(@.get('workstation_ids') ? [], w.id.toString())
    )
