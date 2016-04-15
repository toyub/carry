class Mis.Collections.StoreServiceTrackings extends Backbone.Collection
  url: '/api/store_service_trackings'

  model: (attrs, options) ->
    new Mis.Models.StoreServiceTracking(attrs,options)
