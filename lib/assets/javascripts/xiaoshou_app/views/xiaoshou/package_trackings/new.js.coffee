class Mis.Views.XiaoshouPackageTrackingsNew extends Backbone.View

  template: JST['xiaoshou/package_trackings/new']

  events:
    'click #newTracking': 'openTrackingForm'
    'click #goToShow': 'goToShow'

  initialize: ->
    @store_package = @model.store_package
    @trackings = @store_package.trackings

    @trackings.on('add', @renderTracking, @)

  render: ->
    @$el.html(@template())
    @renderNav()
    @renderPackage()
    @renderItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster()
    @$("#masterNav").html view.render().el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @store_package)
    @$("#packageSummary").html view.render().el

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsListItem(model: item)
    @$("#itemList").append view.render().el

  openTrackingForm: ->
    model = new Mis.Models.StorePackageTracking(store_package: @store_package)
    view = new Mis.Views.XiaoshouPackageTrackingsForm(model: model, collection: @trackings)
    @$("#trackingForm").html view.render().el
    view.open()

  renderTracking: (tracking) ->
    view = new Mis.Views.XiaoshouPackageTrackingsItem(model: tracking)
    @$("#trackingList").append view.render().el

  goToShow: ->
    view = new Mis.Views.XiaoshouPackageTrackingsShow(model: @model)
    $("#bodyContent").html view.render().el
