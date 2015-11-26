class Mis.Models.StoreCustomer extends Backbone.Model

  urlRoot: '/api/store_customers'

  modelName: 'store_customer'

  defaults:
    gender: true

  male: ->
    String(@get 'gender') == 'true'

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    json.district = {province: @get 'province', city: @get 'city', region: @get 'region'}
    hashWithRoot[@modelName] = json
    hashWithRoot
