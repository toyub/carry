class Mis.Routers.StorePackages extends Mis.Base.Router
  routes:
    "api/store_packages": "index"
    "api/store_packages/:id": "show"

  initialize: (options) ->
    @collection = options.collection

  show: (id) ->
    model = new Mis.Models.StorePackage(id: id)
    model.fetch()
    view = new Mis.Views.XiaoshouPackagesShow(model: model, collection: @collection)
    $("#bodyContent").html view.render().el

  index: ->
    view = new Mis.Views.XiaoshouPackagesIndex(collection: @collection)
    $("#bodyContent").html view.render().el
