class Mis.Views.XiaoshouPackageNavsMaster extends Mis.Base.View

  tagName: 'ul'

  template: JST['xiaoshou/package_navs/master']

  events:
    'click a.setting': 'goToSetting'
    'click a.tracking': 'goToTracking'
    'click a.package': 'goToPackage'
    'click a.sale': 'goToSale'

  initialize: (options) ->
    @active = options.active
    @setting = @model.package_setting

  render: ->
    @$el.html(@template(view: @))
    @

  goToSetting: ->
    unless @model.isNew()
      self = this
      @setting.fetch(success: () ->
        self.parent.leave()
        view = new Mis.Views.XiaoshouPackageSettingsShow(model: self.setting)
        $("#bodyContent").html view.render().el
      )

  goToTracking: ->
    unless @model.isNew()
      @parent.leave()
      view = new Mis.Views.XiaoshouPackageTrackingsShow(model: @setting)
      $("#bodyContent").html view.render().el

  goToPackage: ->
    unless @model.isNew()
      @parent.leave()
      view = new Mis.Views.XiaoshouPackageProfilesShow(model: @model)
      $("#bodyContent").html view.render().el

  goToSale: ->
    unless @model.isNew()
      self = this
      @setting.fetch(success: () ->
        self.parent.leave()
        view = new Mis.Views.XiaoshouPackageSalesShow(model: self.setting)
        $("#bodyContent").html view.render().el
      )
