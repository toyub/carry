class Mis.Views.XiaoshouPackageSettingsEdit extends Backbone.View

  template: JST['xiaoshou/package_settings/edit']

  events:
    'submit #newPackageSetting': 'savePackageSetting'
    'click #openPackageItemForm': 'openPackageItemForm'
    'click #periodEnable': 'togglePeriodEnable'
    'click #noticeRequired': 'toggleNoticeRequired'

  initialize: ->
    @model.items.on('add', @renderItem, @)
    @model.on('sync', @handleSuccess, @)

  render: ->
    console.log @model
    @$el.html(@template(setting: @model))
    @renderNav()
    @renderPackage()
    @renderItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model.store_package, active: 'setting')
    @$("#masterNav").html view.render().el

  #renderSubNav: ->
    #view = new Mis.Views.XiaoshouPackageNavsSub()
    #@$("#subNav").html view.render().el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @model.store_package)
    @$("#packageSummary").html view.render().el

  savePackageSetting: (e) ->
    e.preventDefault()
    attrs = @$("#newPackageSetting").find("input, select").serializeJSON()
    @model.set attrs
    console.log @model
    console.log @model.toJSON()
    @model.save()

  openPackageItemForm: ->
    model = new Mis.Models.StorePackageItem(package_setting: @model)
    view = new Mis.Views.XiaoshouPackageItemsForm(model: model)
    view.open()

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsPackageItem(model: item)
    @$("#itemList").append view.render().el

  togglePeriodEnable: (e) ->
    if $(e.target).attr('checked')
      $(e.target).attr('checked', false)
      $(".period").attr('disabled', true)
    else
      $(e.target).attr('checked', 'checked')
      $(".period").attr('disabled', false)

  toggleNoticeRequired: (e) ->
    if $(e.target).attr('checked')
      $(e.target).attr('checked', false)
      $("#beforeExpiredDays").attr('disabled', true)
    else
      $(e.target).attr('checked', 'checked')
      $("#beforeExpiredDays").attr('disabled', false)

  handleSuccess: ->
    view = new Mis.Views.XiaoshouPackageSettingsShow(model: @model)
    $("#bodyContent").html(view.render().el)

  #goToTracking: ->
    #view = new Mis.Views.XiaoshouPackageTrackingsNew(model: @model)
    #$("#bodyContent").html view.render().el
