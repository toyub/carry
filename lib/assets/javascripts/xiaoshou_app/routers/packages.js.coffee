class Mis.Routers.Packages extends Mis.Base.Router
  routes:
    "api/store_packages/:id": "show"

  initialize: (options) ->
    @collection = options.collection

  show: (id) ->
    model = new Mis.Models.StorePackage(id: id)
    model.fetch()
    view = new Mis.Views.XiaoshouPackagesShow(model: model)
    $("#bodyContent").html view.render().el
