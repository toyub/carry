class Mis.Views.XiaoshouServiceSettingsShow extends Backbone.View

  template: JST['xiaoshou/service/settings/show']

  events:
    'click #editSetting': 'goToEdit'

  initialize: ->
    @store = Mis.store
    @model.on('sync', @renderSettings, @)

  render: ->
    @$el.html(@template(setting: @model))
    @renderNav()
    @renderProfileSummary()
    @renderSettings()
    @

  renderSettings: ->
    if @model.isRegular()
      view = new Mis.Views.XiaoshouServiceSettingsRegular(model: @model)
    else
      view = new Mis.Views.XiaoshouServiceSettingsWorkflow(model: @model)
    @$("#settings").html(view.render().el)

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model.store_service, active: 'setting')
    @$("#masterNav").html view.render().el

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @$("#profileSummary").html view.render().el

  goToEdit: ->
    view = new Mis.Views.XiaoshouServiceSettingsEdit(model: @model)
    $("#bodyContent").html(view.render().el)
