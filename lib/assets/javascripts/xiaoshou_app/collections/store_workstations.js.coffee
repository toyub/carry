class Mis.Collections.StoreWorkstations extends Backbone.Collection
  url: '/api/store_workstations'

  model: Mis.Models.StoreWorkstation

  workstation_ids: ->
    @pluck('id').join(",")
