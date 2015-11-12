class Mis.Collections.StorePackageTrackings extends Backbone.Collection
  model: Mis.Models.StorePackageTracking

  initialize: (options) ->
    @store_package = options.store_package

  url: ->
    @store_package.url() + '/store_package_trackings'

