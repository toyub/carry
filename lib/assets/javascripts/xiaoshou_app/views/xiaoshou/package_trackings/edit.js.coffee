class Mis.Views.XiaoshouPackageTrackingsEdit extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_trackings/edit']

  events:
    'click #newTracking': 'openTrackingForm'
    'click #goToShow': 'goToShow'

  initialize: ->
    @store_package = @model.store_package
    @trackings = @store_package.trackings

    @listenTo(@trackings, 'add', @renderTracking)

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderNav()
    @renderPackage()
    @renderItems()
    @renderTrackings()
    @

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @store_package, active: 'tracking')
    @renderChildInto(nav, @$("#masterNav"))

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @store_package)
    @renderChildInto(view, @$("#packageSummary"))

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsListItem(model: item)
    @appendChildTo(view, @$("#itemList"))

  openTrackingForm: ->
    model = new Mis.Models.StorePackageTracking(store_package: @store_package)
    view = new Mis.Views.XiaoshouPackageTrackingsForm(model: model, collection: @trackings)
    @renderChildInto(view, @$("#trackingForm"))

  renderTrackings: ->
    @trackings.each @renderTracking

  renderTracking: (tracking) =>
    view = new Mis.Views.XiaoshouPackageTrackingsItem(model: tracking)
    @appendChildTo(view, @$("#trackingList"))

  goToShow: ->
    @leave()
    view = new Mis.Views.XiaoshouPackageTrackingsShow(model: @model)
    $("#bodyContent").html view.render().el

  rootResource: ->
    "package"

  subResource: ->
    "trackings"

  action: ->
    "edit"
