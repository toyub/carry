class Mis.Views.XiaoshouServiceSettingsEdit extends Backbone.View

  template: JST['xiaoshou/service/settings/edit']

  initialize: ->
    @store = window.Store

  render: ->
    @$el.html(@template(setting: @model))
    @renderNav()
    @renderSubNav()
    @renderProfileSummary()
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
