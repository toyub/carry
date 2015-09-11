class Mis.Models.StoreServiceWorkflow extends Backbone.Model

  urlRoot: '/api/store_service_workflows'

  modelName: 'store_service_workflow'

  defaults:
    engineer_count_enable: true

  clear: ->
    @destroy(wait: true)
