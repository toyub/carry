class Mis.Models.StoreWorkstationCategory extends Backbone.Model

  urlRoot: '/api/store_workstation_category'

  modelName: 'store_workstation_category'

  initialize: ->
    @parseWorkstations()

  parseWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations(@get 'workstations')
