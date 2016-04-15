class Mis.Views.XiaoshouServiceTrackingsEdit extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/service/trackings/edit']

  initialize: ->
    @store_service = @model.store_service

    @listenTo(@store_service.trackings, 'add', @renderTracking)

  events:
    'click #newTracking': 'openTrackingForm'
    'click #save': 'goToShow'

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderNav()
    @renderProfileSummary()
    @renderReminds()
    @renderTrackings()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @store_service, active: 'tracking')
    @renderChildInto(view, @$("#masterNav"))

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @renderChildInto(view, @$("#profileSummary"))

  renderReminds: ->
    @model.store_service.reminds.each @renderRemind

  renderRemind: (remind) =>
    view = new Mis.Views.XiaoshouServiceRemindsItem(model: remind)
    @appendChildTo(view, @$("#reminds"))

  openTrackingForm: ->
    model = new Mis.Models.StoreServiceTracking({}, store_service: @store_service)
    view = new Mis.Views.XiaoshouServiceTrackingsForm(model: model)
    @appendChildTo(view, @$(".tracking_list"))

  renderTracking: (tracking) =>
    view = new Mis.Views.XiaoshouServiceTrackingsItem(model: tracking)
    @appendChildTo(view, @$("#trackingList"))
    @$("#trackingList").parent().show()

  renderTrackings: ->
    @store_service.trackings.each @renderTracking

  goToShow: ->
    @leave()
    view = new Mis.Views.XiaoshouServiceTrackingsShow(model: @model)
    $("#bodyContent").html view.render().el

  rootResource: ->
    "service"

  subResource: ->
    "trackings"

  action: ->
    "edit"
