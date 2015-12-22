class Mis.Routers.StoreCustomerEntities extends Mis.Base.Router
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
      console.log model.toJSON()
      self.swap(view)
    )

  edit: (id) ->
    model = @collection.get(id)
    self = this
    model.fetch(success: () ->
      view = new Mis.Views.KehuCustomerProfilesEdit(model: model, collection: self.collection)
      self.swap(view)
    )

  index: ->
    view = new Mis.Views.KehuCustomerProfilesIndex(collection: @collection)
    @swap(view)

  newCustomer: ->
    model = new Mis.Models.StoreCustomerEntity()
    view = new Mis.Views.KehuCustomerProfilesNew(model: model, collection: @collection)
    @swap(view)
