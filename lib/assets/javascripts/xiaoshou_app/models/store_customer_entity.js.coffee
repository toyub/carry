class Mis.Models.StoreCustomerEntity extends Backbone.Model

  urlRoot: '/api/store_customer_entities'

  modelName: 'store_customer_entity'

  initialize: ->
    @on("change:store_customer", @parseStoreCustomer)
    @on("change:store_customer_settlement", @parseStoreCustomerSettlement)

    @parseStoreCustomer()
    @parseStoreCustomerSettlement()

  parseStoreCustomer: ->
    @storeCustomer = new Mis.Models.StoreCustomer(@get 'store_customer')

  parseStoreCustomerSettlement: ->
    @storeCustomerSettlement = new Mis.Models.StoreCustomerSettlement(@get 'store_customer_settlement')

  propertyName: ->
    Mis.Settings.Entity.properties[@get 'property']

  category: ->
    Mis.store.customerCategories.get(@get 'store_customer_category_id') || new Mis.Models.NullObject()

  categoryName: ->
    @category().get 'name'

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    json.district = {province: @get('province'), city: @get('city'), region: @get('region')}
    json.store_customer_attributes = @storeCustomer.attributes
    json.store_customer_settlement_attributes = @storeCustomerSettlement.attributes
    hashWithRoot[@modelName] = json
    hashWithRoot
