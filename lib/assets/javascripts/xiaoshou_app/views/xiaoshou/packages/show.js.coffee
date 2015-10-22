class Mis.Views.XiaoshouPackagesShow extends Backbone.View

  template: JST['xiaoshou/packages/show']

  events:
    'click #preview_list img': 'previewImage'

  render: ->
    @$el.html(@template(package: @model))
    @renderNav()
    @renderSubNav()
    #@renderPackageItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster()
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouPackageNavsSub()
    @$("#subNav").html view.render().el

  renderPackageItems: ->
    if @model.packageItems.length
      @model.packageItems.each @renderPackageItem
    else
      @$("#packageItemList").hide()

  renderPackageItem: (item) ->
    view = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @$("#packageItemList").append view.render().el

  previewImage: (event) ->
    src = $(event.target).attr('src')
    image = "<img src='#{src}' />"
    @$("#material_img_preview").html(image)
