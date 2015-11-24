class Mis.Models.Store extends Backbone.Model

  urlRoot: '/api/stores'

  modelName: 'store'

  initialize: ->
    @on('change:root_material_categories', @parseRootMaterialCategories, @)
    @on('change:materials', @parseMaterials, @)
    @on('change:services', @parseServies, @)
    @on('change:packages', @parsePackages, @)
    @on('change:customers', @parseCustomers, @)

    @parseServices()
    @parsePackages()
    @parseCustomers()
    @parseRootMaterialCategories()
    @parseMaterials()
    @parseWorkstationCategories()
    @parseWorkstations()
    @parseCommissionTemplates()

  parseRootMaterialCategories: ->
    @rootMaterialCategories = new Mis.Collections.StoreMaterialCategories(@get 'root_material_categories')

  parseMaterials: ->
    @materials = new Mis.Collections.StoreMaterials(@get 'materials')

  parsePackages: ->
    @packages = new Mis.Collections.StorePackages(@get 'packages')

  parseCustomers: ->
    @customers = new Mis.Collections.StoreCustomers(@get 'customers')

  parseServices: ->
    @services = new Mis.Collections.StoreServices(@get 'services')

  parseWorkstationCategories: ->
    @workstationCategories = new Mis.Collections.StoreWorkstationCategories(@get 'store_workstation_categories')

  parseWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations(@get 'workstations')

  parseCommissionTemplates: ->
    @commissionTemplates = new Mis.Collections.StoreCommissionTemplates(@get 'commissions')
