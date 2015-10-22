class Mis.Models.StorePackageSetting extends Backbone.Model

  urlRoot: '/api/store_package_settings'

  modelName: 'store_package_setting'

  initialize: (options) ->
    @store_package = options.store_package
