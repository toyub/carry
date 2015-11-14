class Mis.Views.XiaoshouPackagesShow extends Backbone.View

  template: JST['xiaoshou/packages/show']

  events:
    'click #preview_list img': 'previewImage'
    'click #editPackage': 'goToEdit'

  render: ->
    @$el.html(@template(package: @model))
    @renderNav()
    @renderPackageItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouPackageNavsSub(package: @model)
    @$("#subNav").html view.render().el

  previewImage: (event) ->
    src = $(event.target).attr('src')
    image = "<img src='#{src}' />"
    @$("#material_img_preview").html(image)

  goToEdit: ->
    view = new Mis.Views.XiaoshouPackagesEdit(model: @model)
    $("#bodyContent").html view.render().el

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @$("#packageItemList").append view.render().el
