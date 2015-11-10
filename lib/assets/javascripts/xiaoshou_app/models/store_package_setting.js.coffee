class Mis.Models.StorePackageSetting extends Backbone.Model

  urlRoot: '/api/store_package_settings'

  modelName: 'store_package_setting'

  url: ->
    @store_package.url() + '/store_package_settings'

  initialize: (options) ->
    @store_package = options.store_package

    @parseItems()

  parseItems: ->
    @items = new Mis.Collections.StorePackageItems(@get 'items')

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    json.items_attributes = @items.map(
      (item) ->
        item.attributes
    )
    hashWithRoot[@modelName] = json
    hashWithRoot
