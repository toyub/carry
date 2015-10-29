class Mis.Views.XiaoshouServiceTrackingsShow extends Backbone.View

  template: JST['xiaoshou/service/trackings/show']

  initialize: ->
    @store_service = @model.store_service

  events:
    'click #edit': 'goToEdit'

  render: ->
    @$el.html(@template())
    @renderNav()
    @renderSubNav()
    @renderProfileSummary()
    @renderReminds()
    @renderTrackings()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster()
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouServiceNavsSub()
    @$("#subNav").html view.render().el

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @$("#profileSummary").html view.render().el

  renderReminds: ->
    @model.store_service.reminds.each @renderRemind

  renderRemind: (remind) =>
    view = new Mis.Views.XiaoshouServiceRemindsItem(model: remind, action: 'show')
    @$("#reminds").append view.render().el

  renderTracking: (tracking) =>
    view = new Mis.Views.XiaoshouServiceTrackingsItem(model: tracking, action: 'show')
    @$("#trackingList").append view.render().el
    @$("#trackingList").parent().show()

  renderTrackings: ->
    @store_service.trackings.each @renderTracking

  goToEdit: ->
    view = new Mis.Views.XiaoshouServiceTrackingsNew(model: @model)
    $("#bodyContent").html view.render().el
