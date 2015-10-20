class Mis.Collections.StoreMaterials extends Backbone.Collection
  url: '/api/store_materials'

  model: Mis.Models.StoreMaterial

  selected: ->
    @where(selected: true)

  clearSelected: ->
    _.each @selected(), @toggleSelected

  toggleSelected: (material) =>
    material.toggleSelected()
