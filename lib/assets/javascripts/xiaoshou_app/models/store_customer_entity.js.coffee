class Mis.Models.StoreCustomerEntity extends Backbone.Model

  urlRoot: '/api/store_customer_entity'

  modelName: 'store_customer_entity'

  initialize: ->
    @on("change:store_customer", @parseStoreCustomer)
    @on("change:store_customer_settlement", @parseStoreCustomerSettlement)

    @parseStoreCustomer()
    @parseStoreCustomerSettlement()

  defaults:
    property: 'personal'

  PROPERPTIES:
    group: '集团客户'
    personal: '个人客户'

  properties: ->
    @PROPERPTIES

  parseStoreCustomer: ->
    @storeCustomer = new Mis.Models.StoreCustomer(@get 'store_customer')

  parseStoreCustomerSettlement: ->
    @storeCustomerSettlement = new Mis.Models.StoreCustomerSettlement(@get 'store_customer_settlement')

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    json.store_customer_attributes = json.storeCustomer.attributes
    json.store_customer_settlement_attributes = json.storeCustomerSettlement.attributes
    hashWithRoot[@modelName] = json
    hashWithRoot
