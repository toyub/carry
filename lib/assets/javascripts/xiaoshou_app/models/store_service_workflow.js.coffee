class Mis.Models.StoreServiceWorkflow extends Backbone.Model

  urlRoot: '/api/store_service_workflows'

  modelName: 'store_service_workflow'

  initialize: ->
    @initWorkstations()

  defaults:
    engineer_count_enable: true

  clear: ->
    @destroy(wait: true)

  initWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations()
    Mis.store.workstations.each(
      (w) =>
        @workstations.add w if _.contains(@.get('workstation_ids') ? [], w.id.toString())
    )
