class Mis.Views.XiaoshouServiceProfilesShow extends Backbone.View

  template: JST['xiaoshou/service/profiles/show']

  events:
    'click #preview_list img': 'previewImage'
    'click #serviceEdit': 'gotoEdit'
    'click #createSettingStub': 'goToSettingNew'

  initialize: ->
    @model.on('sync', @renderMaterials, @)

  render: ->
    @$el.html(@template(service: @model))
    @renderMaterials()
    @

  previewImage: (event) ->
    src = $(event.target).attr('src')
    image = "<img src='#{src}' />"
    @$("#material_img_preview").html(image)

  gotoEdit: ->
    view = new Mis.Views.XiaoshouServiceProfilesEdit(model: @model)
    @$("div.details_content").html(view.render().el)

  renderMaterials: =>
    console.log('xxxx')
    @$(".materialList").empty()
    @model.materials.each @addMaterial

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'show')
    @$(".materialList").append view.render().el

  goToSettingNew: ->
    model = new Mis.Models.StoreServiceSetting(store_service: @model)
    view = new Mis.Views.XiaoshouServiceSettingsNew(model: model)
    $("#bodyContent").html(view.render().el)

