class Mis.Views.XiaoshouServiceSettingsShow extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/service/settings/show']

  events:
    'click #editSetting': 'goToEdit'

  initialize: ->
    @store = Mis.store

  render: ->
    @$el.html(@template(setting: @model))
    @renderTop()
    @renderNav()
    @renderProfileSummary()
    @renderSettings()
    @

  renderSettings: ->
    if @model.isRegular()
      view = new Mis.Views.XiaoshouServiceSettingsRegular(model: @model)
    else
      view = new Mis.Views.XiaoshouServiceSettingsWorkflow(model: @model)
    @renderChildInto(view, @$("#settings"))

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model.store_service, active: 'setting')
    @renderChildInto(view, @$("#masterNav"))

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @renderChildInto(view, @$("#profileSummary"))

  goToEdit: ->
    @leave()
    view = new Mis.Views.XiaoshouServiceSettingsEdit(model: @model)
    $("#bodyContent").html(view.render().el)

  rootResource: ->
    "service"

  subResource: ->
    "settings"

  action: ->
    "show"
