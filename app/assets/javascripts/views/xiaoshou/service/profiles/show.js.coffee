class Mis.Views.XiaoshouServiceProfilesShow extends Backbone.View

  template: JST['xiaoshou/service/profiles/show']

  events:
    'click #preview_list img': 'previewImage'
    'click #serviceEdit': 'gotoEdit'

  render: ->
    @$el.html(@template(service: @model))
    @model.materials.each @addMaterial
    @

  previewImage: (event) ->
    src = $(event.target).attr('src')
    image = "<img src='#{src}' />"
    @$("#material_img_preview").html(image)

  gotoEdit: ->
    view = new Mis.Views.XiaoshouServiceProfilesEdit(model: @model)
    @$("div.details_content").html(view.render().el)

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'show')
    @$(".materialList").append view.render().el
