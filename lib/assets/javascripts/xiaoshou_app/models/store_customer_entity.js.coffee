class Mis.Models.StoreCustomerEntity extends Backbone.Model

  urlRoot: '/api/store_customer_entities'

  modelName: 'store_customer_entity'

  initialize: ->
    @on("change:store_customer", @parseStoreCustomer)
    @on("change:store_customer_settlement", @parseStoreCustomerSettlement)
    @on("change:cities", @parseCities)
    @on("change:regions", @parseRegions)

    @parseCities()
    @parseRegions()
    @parseStoreCustomer()
    @parseStoreCustomerSettlement()

  parseCities: ->
    @cities = @get 'cities'

  parseRegions: ->
    @regions = @get 'regions'

  parseStoreCustomer: ->
    @storeCustomer = new Mis.Models.StoreCustomer(@get 'store_customer')

  parseStoreCustomerSettlement: ->
    @storeCustomerSettlement = new Mis.Models.StoreCustomerSettlement(@get 'store_customer_settlement')

  propertyName: ->
    @get 'property_i18n'

  category: ->
    Mis.store.customerCategories.get(@get 'store_customer_category_id') || new Mis.Models.NullObject()

  categoryName: -> @category().get 'name'

  province: ->
    if @get 'province'
      Mis.store.provinces.find (province) =>
        province.code == @get 'province'
      .name

  city: ->
    if @get 'city'
      @get('cities').find (city) =>
        city.code == @get 'city'
      .name

  region: ->
    if @get 'region'
      @get('regions').find (region) =>
        region.code == @get 'region'
      .name

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    json.district = {province: @get('province'), city: @get('city'), region: @get('region')}
    json.store_customer_attributes = @storeCustomer.toJSON()
    json.store_customer_settlement_attributes = @storeCustomerSettlement.attributes
    hashWithRoot[@modelName] = json
    hashWithRoot
