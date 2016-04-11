class Mis.Models.Store extends Backbone.Model

  urlRoot: '/api/stores'

  modelName: 'store'

  initialize: ->
    @on('change:root_material_categories', @parseRootMaterialCategories, @)
    @on('change:materials', @parseMaterials, @)
    @on('change:services', @parseServices, @)
    @on('change:service_categories', @parseServiceCategories, @)
    @on('change:packages', @parsePackages, @)
    @on('change:customers', @parseCustomers, @)
    @on('change:customer_categories', @parseCustomerCategories, @)
    @on('change:provinces', @parseProvinces, @)
    @on('change:cities', @parseCities, @)
    @on('change:regions', @parseRegions, @)

    @parseRootMaterialCategories()
    @parseWorkstations()
    @parseServices()
    @parseServiceCategories()
    @parsePackages()
    @parseCustomers()
    @parseMaterials()
    @parseWorkstationCategories()
    @parseCommissionTemplates()
    @parseCustomerCategories()
    @parseProvinces()
    @parseTags()
    @parseMachanicCommissionTemplates()

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
    @services = new Mis.Collections.StoreServices(@get('services'), store: @)

  parseWorkstationCategories: ->
    @workstationCategories = new Mis.Collections.StoreWorkstationCategories(@get 'store_workstation_categories')

  parseWorkstations: ->
    @workstations = new Mis.Collections.StoreWorkstations(@get 'workstations')

  parseCommissionTemplates: ->
    @commissionTemplates = new Mis.Collections.StoreCommissionTemplates(@get 'commissions')

  parseMachanicCommissionTemplates: ->
    @machanicCommissionTemplates = new Mis.Collections.StoreCommissionTemplates(@get 'machanic_commissions')

  parseCustomerCategories: ->
    @customerCategories = new Mis.Collections.StoreCustomerCategories(@get 'customer_categories')

  parseProvinces: ->
    @provinces = @get 'provinces'

  parseServiceCategories: ->
    @serviceCategories = new Mis.Collections.StoreServiceCategories(@get 'service_categories')
