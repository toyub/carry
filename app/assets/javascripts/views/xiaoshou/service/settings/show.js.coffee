class Mis.Views.XiaoshouServiceSettingsShow extends Backbone.View

  template: JST['xiaoshou/service/settings/show']

  events:
    'click a.profile': 'goToProfilesShow'
    'click #editSetting': 'goToEdit'
    'click a.tracking': 'goToTrackingNew'

  initialize: ->
    @store = window.Store
    @model.on('sync', @renderSettings, @)

  render: ->
    @$el.html(@template(setting: @model))
    @renderNav()
    @renderSubNav()
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
    view = new Mis.Views.XiaoshouServiceNavsMaster()
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouServiceNavsSub()
    @$("#subNav").html view.render().el

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @$("#profileSummary").html view.render().el

  goToProfilesShow: ->
    view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model.store_service)
    $("#bodyContent").html(view.render().el)

  goToEdit: ->
    view = new Mis.Views.XiaoshouServiceSettingsEdit(model: @model)
    $("#bodyContent").html(view.render().el)

  goToTrackingNew: ->
    console.log 'tracking'
    console.log @model.store_service
    view = new Mis.Views.XiaoshouServiceTrackingsNew(model: @model)
    $("#bodyContent").html view.render().el
