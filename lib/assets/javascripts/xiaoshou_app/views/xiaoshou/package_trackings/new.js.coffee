class Mis.Views.XiaoshouPackageTrackingsNew extends Backbone.View

  template: JST['xiaoshou/package_trackings/new']

  events:
    'click #newTracking': 'openTrackingForm'

  initialize: ->
    @trackings = @model.package_setting.store_package.trackings

    @trackings.on('add', @renderTracking, @)

  render: ->
    @$el.html(@template())
    @renderNav()
    @renderSubNav()
    @renderPackage()
    @renderItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster()
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouPackageNavsSub()
    @$("#subNav").html view.render().el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @model.package_setting.store_package)
    @$("#packageSummary").html view.render().el

  renderItems: ->
    @model.package_setting.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsListItem(model: item)
    @$("#itemList").append view.render().el

  openTrackingForm: ->
    view = new Mis.Views.XiaoshouPackageTrackingsForm(model: @model)
    @$("#trackingForm").html view.render().el
    view.open()

  renderTracking: ->
    view = new Mis.Views.XiaoshouPackageTrackingsItem(model: @model)
    @$("#trackingList").append view.render().el
