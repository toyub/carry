class Mis.Routers.StorePackages extends Support.SwappingRouter
  routes:
    "": "index"
    "store_packages/:id": "show"
    "store_packages/:id/edit": "edit"

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

  edit: (packageId) ->
    model = @collection.get(packageId)
    view = new Mis.Views.XiaoshouPackagesEdit(model: model, collection: @collection)
    @swap(view)

  index: ->
    view = new Mis.Views.XiaoshouPackagesIndex(collection: @collection)
    @swap(view)
