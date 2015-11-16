class Mis.Views.XiaoshouServiceTrackingsNew extends Backbone.View

  template: JST['xiaoshou/service/trackings/new']

  initialize: ->
    @store_service = @model.store_service

    @store_service.trackings.on('add', @renderTracking, @)

  events:
    'click #newTracking': 'openTrackingForm'
    'click #save': 'goToShow'

  render: ->
    @$el.html(@template())
    @renderNav()
    @renderProfileSummary()
    @renderReminds()
    @renderTrackings()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @store_service, active: 'tracking')
    @$("#masterNav").html view.render().el

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @$("#profileSummary").html view.render().el

  renderReminds: ->
    @model.store_service.reminds.each @renderRemind

  renderRemind: (remind) =>
    view = new Mis.Views.XiaoshouServiceRemindsItem(model: remind)
    @$("#reminds").append view.render().el

  openTrackingForm: ->
    model = new Mis.Models.StoreServiceTracking(store_service: @store_service)
    view = new Mis.Views.XiaoshouServiceTrackingsForm(model: model)
    view.open()

  renderTracking: (tracking) =>
    view = new Mis.Views.XiaoshouServiceTrackingsItem(model: tracking)
    @$("#trackingList").append view.render().el
    @$("#trackingList").parent().show()

  renderTrackings: ->
    @store_service.trackings.each @renderTracking

  goToShow: ->
    view = new Mis.Views.XiaoshouServiceTrackingsShow(model: @model)
    $("#bodyContent").html view.render().el
