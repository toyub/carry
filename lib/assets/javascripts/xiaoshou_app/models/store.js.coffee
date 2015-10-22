class Mis.Models.Store extends Backbone.Model

  urlRoot: '/api/stores'

  modelName: 'store'

  initialize: ->
    @on('change:root_material_categories', @parseRootMaterialCategories, @)
    @on('change:store_materials', @parseMaterials, @)
    @on('change:service_categories', @parseServiceCategories, @)
    @parseRootMaterialCategories()
    @parseMaterials()
    @parseServiceCategories()
    @parseWorkstationCategories()
    @parseWorkstations()
    @parseCommissionTemplates()

  parseRootMaterialCategories: ->
    @rootMaterialCategories = new Mis.Collections.StoreMaterialCategories(@get 'root_material_categories')

  parseMaterials: ->
    @materials = new Mis.Collections.StoreMaterials(@get 'store_materials')

  parseServiceCategories: ->
    @serviceCategories = new Mis.Collections.StoreServiceCategories(@get 'service_categories')

  parseWorkstationCategories: ->
    @workstationCategories = new Mis.Collections.StoreWorkstationCategories(@get 'store_workstation_categories')

  parseWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations(@get 'workstations')

  parseCommissionTemplates: ->
    @commissionTemplates = new Mis.Collections.StoreCommissionTemplates(@get 'commission_templates')
