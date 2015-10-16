class Mis.Models.StoreMaterial extends Backbone.Model

  urlRoot: '/api/store_materials'

  modelName: 'store_material'

  defaults:
    selected: false

  toggleSelected: ->
    @set(selected: !@get('selected'))
