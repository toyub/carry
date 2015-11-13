class Mis.Views.XiaoshouPackageNavsMaster extends Backbone.View

  tagName: 'ul'

  template: JST['xiaoshou/package_navs/master']

  events:
    'click a.setting': 'goToSetting'
    'click a.tracking': 'goToTracking'
    'click a.package': 'goToPackage'

  initialize: (options) ->
    @active = options.active

  render: ->
    @$el.html(@template(view: @))
    @

  goToSetting: ->
    unless @model.isNew()
      view = new Mis.Views.XiaoshouPackageSettingsEdit(model: @model.package_setting)
      $("#bodyContent").html view.render().el

  goToTracking: ->
    unless @model.isNew()
      view = new Mis.Views.XiaoshouPackageTrackingsEdit(model: @model.package_setting)
      $("#bodyContent").html view.render().el

  goToPackage: ->
    unless @model.isNew()
      view = new Mis.Views.XiaoshouPackagesShow(model: @model)
      $("#bodyContent").html view.render().el
