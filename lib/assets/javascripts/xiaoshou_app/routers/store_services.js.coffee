class Mis.Routers.StoreServices extends Mis.Base.Router
  routes:
    "api/store_services/:id": "show"

  initialize: (options) ->
    @collection = options.collection

  show: (id) ->
    model = new Mis.Models.StoreService(id: id)
    model.fetch()
    view = new Mis.Views.XiaoshouServiceProfilesShow(model: model)
    $("#bodyContent").html view.render().el
