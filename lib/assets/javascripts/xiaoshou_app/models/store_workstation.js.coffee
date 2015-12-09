class Mis.Models.StoreWorkstation extends Backbone.Model

  urlRoot: '/api/store_workstations'

  modelName: 'store_workstation'

  defaults:
    checked: false

  toggleChecked: ->
    @set(checked: !@get('checked'))
