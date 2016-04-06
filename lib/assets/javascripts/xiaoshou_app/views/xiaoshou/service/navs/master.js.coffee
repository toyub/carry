class Mis.Views.XiaoshouServiceNavsMaster extends Mis.Base.View

  tagName: 'ul'

  template: JST['xiaoshou/service/navs/master']

  initialize: (options) ->
    @active = options.active
    @setting = @model.setting

  events:
    'click a.setting': 'goToSetting'
    'click a.tracking': 'goToTracking'
    'click a.service': 'goToService'

  render: ->
    @$el.html(@template(view: @))
    @

  goToSetting: ->
    unless @model.isNew()
      self = @
      @setting.fetch(success: () ->
        self.parent.leave()
        view = new Mis.Views.XiaoshouServiceSettingsShow(model: self.setting)
        $("#bodyContent").html view.render().el
      )

  goToTracking: ->
    unless @model.isNew()
      self = @
      @setting.fetch(success: () ->
        self.parent.leave()
        view = new Mis.Views.XiaoshouServiceTrackingsShow(model: self.setting)
        $("#bodyContent").html view.render().el
      )

  goToService: ->
    unless @model.isNew()
      @parent.leave()
      view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model)
      $("#bodyContent").html view.render().el
