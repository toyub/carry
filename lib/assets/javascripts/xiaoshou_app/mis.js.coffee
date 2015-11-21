window.Mis =
  Models: {}
  Collections: {}
  Views:
    Concerns: {}
  Routers: {}
  Mixins: {}
  Base: {}
  initialize: (data) ->
    @packages = new Mis.Collections.StorePackages(data.packages)
    @materials = new Mis.Collections.StoreMaterials(data.materials)
    @services = new Mis.Collections.StoreServices(data.services)
    @commissions = new Mis.Collections.StoreCommissionTemplates(data.commissions)
    new Mis.Routers.StorePackages(collection: @packages)
    new Mis.Routers.StoreServices(collection: @services)
    if not Backbone.History.started
      Backbone.history.start()
