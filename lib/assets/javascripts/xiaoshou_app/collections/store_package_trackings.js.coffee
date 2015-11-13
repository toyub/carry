class Mis.Collections.StorePackageTrackings extends Backbone.Collection
  model: Mis.Models.StorePackageTracking

  initialize: (trackings, options = {}) ->
    super(trackings)

    @store_package = options.store_package

  url: ->
    @store_package.url() + '/store_package_trackings'

