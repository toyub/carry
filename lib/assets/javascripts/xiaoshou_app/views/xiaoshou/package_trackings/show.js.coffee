class Mis.Views.XiaoshouPackageTrackingsShow extends Backbone.View

  template: JST['xiaoshou/package_trackings/show']

  events:
    'click #goToEdit': 'goToEdit'

  initialize: ->
    @store_package = @model.store_package
    @trackings = @store_package.trackings

  render: ->
    @$el.html(@template())
    @renderNav()
    @renderSubNav()
    @renderPackage()
    @renderItems()
    @renderTrackings()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster()
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouPackageNavsSub()
    @$("#subNav").html view.render().el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @store_package)
    @$("#packageSummary").html view.render().el

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsListItem(model: item)
    @$("#itemList").append view.render().el

  renderTrackings: ->
    @trackings.each @renderTracking

  renderTracking: (tracking) =>
    view = new Mis.Views.XiaoshouPackageTrackingsItem(model: tracking, action: 'show')
    @$("#trackingList").append view.render().el

  goToEdit: ->
    view = new Mis.Views.XiaoshouPackageTrackingsEdit(model: @model)
    $("#bodyContent").html view.render().el
