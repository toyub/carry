class Mis.Routers.StoreCustomers extends Mis.Base.Router
  routes:
    "store_customers": "index"
    "store_customers/new": "newCustomer"
    "store_customers/:id": "show"
    "store_customers/:id/edit": "edit"

  initialize: (options) ->
    @el = $('#bodyContent')
    @collection = options.collection

  show: (id) ->
    model = @collection.get(id)
    self = this
    model.fetch(success: () ->
      view = new Mis.Views.KehuCustomerProfilesShow(model: model, collection: self.collection)
      self.swap(view)
    )

  edit: (packageId) ->
    model = @collection.get(packageId)
    view = new Mis.Views.KehuCustomerProfilesEdit(model: model, collection: @collection)
    @swap(view)

  index: ->
    view = new Mis.Views.KehuCustomerProfilesIndex(collection: @collection)
    @swap(view)

  newPackage: ->
    model = new Mis.Models.StoreCustomer()
    view = new Mis.Views.KehuCustomerProfilesNew(model: model, collection: @collection)
    @swap(view)
