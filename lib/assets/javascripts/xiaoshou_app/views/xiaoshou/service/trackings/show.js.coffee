class Mis.Views.XiaoshouServiceTrackingsShow extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/service/trackings/show']

  initialize: ->
    @store_service = @model.store_service

  events:
    'click #edit': 'goToEdit'

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
    view = new Mis.Views.XiaoshouServiceRemindsItem(model: remind, action: 'show')
    @appendChildTo(view, @$("#reminds"))

  renderTracking: (tracking) =>
    view = new Mis.Views.XiaoshouServiceTrackingsItem(model: tracking, action: 'show')
    @appendChildTo(view, @$("#trackingList"))
    @$("#trackingList").parent().show()

  renderTrackings: ->
    @store_service.trackings.each @renderTracking

  goToEdit: ->
    @leave()
    view = new Mis.Views.XiaoshouServiceTrackingsEdit(model: @model)
    $("#bodyContent").html view.render().el

  rootResource: ->
    "service"

  subResource: ->
    "trackings"

  action: ->
    "show"
