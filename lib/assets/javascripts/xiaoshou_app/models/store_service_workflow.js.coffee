class Mis.Models.StoreServiceWorkflow extends Backbone.Model

  urlRoot: '/api/store_service_workflows'

  modelName: 'store_service_workflow'

  initialize: ->
    @initWorkstations()

  defaults:
    engineer_count_enable: true

  clear: ->
    @destroy(wait: true)

  workstationName: ->
    if @get("nominated_workstation")
      @workstations.map(
        (w) ->
          w.get "name"
      ).join("，")
    else
      "不限"

  engineerLevel: ->
    level = undefined
    _.each Mis.store.get("engineer_levels"), (value, key) =>
      level = value if String(key) == String(@get("engineer_level"))
    level

  commissionName: ->
    commission = Mis.store.commissionTemplates.find(
      (c) =>
        String(c.id) == String(@get("mechanic_commission_template_id"))
    )
    commission.get("name") if commission

  initWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations()
    Mis.store.workstations.each(
      (w) =>
        @workstations.add w if _.contains(@.get('workstation_ids') ? [], w.id.toString())
    )
