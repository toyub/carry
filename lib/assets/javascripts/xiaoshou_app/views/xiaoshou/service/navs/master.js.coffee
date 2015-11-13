class Mis.Views.XiaoshouServiceNavsMaster extends Backbone.View

  tagName: 'ul'

  template: JST['xiaoshou/service/navs/master']

  initialize: (options) ->
    @active = options.active

  events:
    'click a.setting': 'goToSetting'
    'click a.tracking': 'goToTracking'
    'click a.service': 'goToService'

  render: ->
    @$el.html(@template(view: @))
    @

  goToSetting: ->
    unless @model.isNew()
      view = new Mis.Views.XiaoshouServiceSettingsEdit(model: @model.setting)
      $("#bodyContent").html view.render().el

  goToTracking: ->
    unless @model.isNew()
      view = new Mis.Views.XiaoshouServiceTrackingsNew(model: @model.setting)
      $("#bodyContent").html view.render().el

  goToService: ->
    unless @model.isNew()
      view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model)
      $("#bodyContent").html view.render().el
