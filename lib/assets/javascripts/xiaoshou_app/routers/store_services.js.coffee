class Mis.Routers.StoreServices extends Mis.Base.Router
  routes:
    "store_services": "index"
    "store_services/new": "new"
    "store_services/:id": "show"
    "store_services/:id/edit": "edit"

  initialize: (options) ->
    @el = $('#bodyContent')
    @collection = options.collection

  show: (id) ->
    model = @collection.get(id)
    self = this
    console.log(model)
    model.fetch(success: () ->
      model.parseMaterials()
      view = new Mis.Views.XiaoshouServiceProfilesShow(model: model, collection: self.collection)
      self.swap(view)
    )

  index: ->
    self = this
    @collection.fetch(success: () =>
      view = new Mis.Views.XiaoshouServiceProfilesIndex(collection: @collection)
      @swap(view)
    )

  edit: (id) ->
    model = @collection.get(id)
    view = new Mis.Views.XiaoshouServiceProfilesEdit(model: model, collection: @collection)
    @swap(view)

  new: ->
    model = new Mis.Models.StoreService()
    view = new Mis.Views.XiaoshouServiceProfilesNew(model: model, collection: @collection)
    @swap(view)
