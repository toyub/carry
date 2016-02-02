class Mis.Collections.StoreServices extends Backbone.Collection
  url: '/api/store_services'

  model: (attrs, options) ->
    new Mis.Models.StoreService(attrs, options)
