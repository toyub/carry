class Mis.Routers.StorePackages extends Support.SwappingRouter
  routes:
    "": "index"
    "store_packages/:id": "show"

  initialize: (options) ->
    @el = $('#bodyContent')
    @collection = options.collection

  show: (id) ->
    model = @collection.get(id)
    self = this
    model.fetch(success: () ->
      view = new Mis.Views.XiaoshouPackagesShow(model: model, collection: self.collection)
      self.swap(view)
    )

  index: ->
    view = new Mis.Views.XiaoshouPackagesIndex(collection: @collection)
    @swap(view)
