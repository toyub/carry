class Mis.Models.Store extends Backbone.Model

  urlRoot: '/api/stores'

  modelName: 'store'

  initialize: ->
    @on('change:root_material_categories', @parseRootMaterialCategories, @)
    @on('change:materials', @parseMaterials, @)
    @on('change:services', @parseServies, @)
    @on('change:packages', @parsePackages, @)
    @on('change:customers', @parseCustomers, @)
    @on('change:customer_categories', @parseCustomerCategories, @)
    @on('change:provinces', @parseProvinces, @)
    @on('change:cities', @parseCities, @)
    @on('change:regions', @parseRegions, @)

    @parseServices()
    @parsePackages()
    @parseCustomers()
    @parseRootMaterialCategories()
    @parseMaterials()
    @parseWorkstationCategories()
    @parseWorkstations()
    @parseCommissionTemplates()
    @parseCustomerCategories()
    @parseProvinces()
    @parseTags()

  parseTags: ->
    @tags = new Mis.Collections.Tags(@get 'tags')

  parseRootMaterialCategories: ->
    @rootMaterialCategories = new Mis.Collections.StoreMaterialCategories(@get 'root_material_categories')

  parseMaterials: ->
    @materials = new Mis.Collections.StoreMaterials(@get 'materials')

  parsePackages: ->
    @packages = new Mis.Collections.StorePackages(@get 'packages')

  parseCustomers: ->
    @customerEntities = new Mis.Collections.StoreCustomerEntities(@get 'customers')

  parseServices: ->
    @services = new Mis.Collections.StoreServices(@get 'services')

  parseWorkstationCategories: ->
    @workstationCategories = new Mis.Collections.StoreWorkstationCategories(@get 'store_workstation_categories')

  parseWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations(@get 'workstations')

  parseCommissionTemplates: ->
    @commissionTemplates = new Mis.Collections.StoreCommissionTemplates(@get 'commissions')

  parseCustomerCategories: ->
    @customerCategories = new Mis.Collections.StoreCustomerCategories(@get 'customer_categories')

  parseProvinces: ->
    @provinces = @get 'provinces'
