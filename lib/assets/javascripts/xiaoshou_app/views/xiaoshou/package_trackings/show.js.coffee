class Mis.Views.XiaoshouPackageTrackingsShow extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_trackings/show']

  events:
    'click #goToEdit': 'goToEdit'

  initialize: ->
    @store_package = @model.store_package
    @trackings = @store_package.trackings

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

  renderTrackings: ->
    @trackings.each @renderTracking

  renderTracking: (tracking) =>
    view = new Mis.Views.XiaoshouPackageTrackingsItem(model: tracking, action: 'show')
    @appendChildTo(view, @$("#trackingList"))

  goToEdit: ->
    @leave()
    view = new Mis.Views.XiaoshouPackageTrackingsEdit(model: @model)
    $("#bodyContent").html view.render().el

  rootResource: ->
    "package"

  subResource: ->
    "trackings"

  action: ->
    "show"
