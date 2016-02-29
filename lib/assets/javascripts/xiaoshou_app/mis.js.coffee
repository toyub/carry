window.Mis =
  Models: {}
  Collections: {}
  Views:
    Concerns: {}
  Routers: {}
  Mixins: {}
  Base: {}
  Settings: {}
  initialize: (data) ->
    @store = new Mis.Models.Store(data)
    @materials = @store.materials
    @services = @store.services
    @commissions = @store.commissionTemplates
    console.log @store.packages
    new Mis.Routers.StorePackages(collection: @store.packages)
    new Mis.Routers.StoreServices(collection: @services)
    new Mis.Routers.StoreCustomerEntities(collection: @store.customerEntities)
    if not Backbone.History.started
      Backbone.history.start()
