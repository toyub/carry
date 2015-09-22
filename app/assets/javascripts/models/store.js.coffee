class Mis.Models.Store extends Backbone.Model

  urlRoot: '/api/stores'

  modelName: 'store'

  initialize: ->
    @on('change:root_material_categories', @parseRootMaterialCategories, @)
    @on('change:store_materials', @parseMaterials, @)
    @parseRootMaterialCategories()
    @parseMaterials()

  parseRootMaterialCategories: ->
    @rootMaterialCategories = new Mis.Collections.StoreMaterialCategories(@get 'root_material_categories')

  parseMaterials: ->
    @materials = new Mis.Collections.StoreMaterials(@get 'store_materials')
