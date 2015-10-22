class Mis.Models.StoreMaterialCategory extends Backbone.Model

  urlRoot: '/api/store_material_categories'

  modelName: 'store_material_category'

  initialize: ->
    @on("change:sub_categories", @parseSubMaterialCategories, @)
    @parseSubMaterialCategories()

  parseSubMaterialCategories: ->
    @subMaterialCategories = new Mis.Collections.StoreMaterialCategories(@get 'sub_categories')

