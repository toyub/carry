class Mis.Views.XiaoshouPackageSettingsEdit extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_settings/edit']

  events:
    'submit #newPackageSetting': 'savePackageSetting'
    'click #openPackageItemForm': 'openPackageItemForm'
    'click #periodEnable': 'togglePeriodEnable'
    'click #noticeRequired': 'toggleNoticeRequired'

  initialize: ->
    @listenTo(@model.items, 'add', @renderItem)
    @listenTo(@model, 'sync', @handleSuccess)

  render: ->
    @$el.html(@template(setting: @model))
    @renderTop()
    @renderNav()
    @renderPackage()
    @renderItems()
    @

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model.store_package, active: 'setting')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @model.store_package)
    @renderChild(view)
    @$("#packageSummary").html view.el

  savePackageSetting: (e) ->
    e.preventDefault()
    @model.set @$("#newPackageSetting").find("input, select").serializeJSON()
    @model.save()

  openPackageItemForm: ->
    model = new Mis.Models.StorePackageItem(package_setting: @model)
    view = new Mis.Views.XiaoshouPackageItemsForm(model: model)
    @renderChildInto(view, $("#newPackageItem"))

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsPackageItem(model: item)
    @renderChild(view)
    @$("#itemList").append view.el

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
    @leave()
    view = new Mis.Views.XiaoshouPackageSettingsShow(model: @model)
    $("#bodyContent").html(view.render().el)
