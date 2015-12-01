window.Mis =
  Models: {}
  Collections: {}
  Views:
    Concerns: {}
  Routers: {}
  Mixins: {}
  Base: {}
  initialize: (data) ->
    @store = new Mis.Models.Store(data)
    @materials = @store.materials
    @services = @store.services
    @commissions = @store.commissionTemplates
    new Mis.Routers.StorePackages(collection: @store.packages)
    new Mis.Routers.StoreServices(collection: @services)
    new Mis.Routers.StoreCustomers(collection: @store.customers)
    if not Backbone.History.started
      Backbone.history.start()
