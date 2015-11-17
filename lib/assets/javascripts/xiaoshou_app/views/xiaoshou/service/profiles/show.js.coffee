class Mis.Views.XiaoshouServiceProfilesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/service/profiles/show']

  events:
    'click #serviceEdit': 'gotoEdit'

  initialize: ->
    @model.on('sync', @renderMaterials, @)
    @model.on('change', @render, @)

  render: ->
    @$el.html(@template(service: @model))
    @renderNav()
    @renderUploadTemplate()
    @renderMaterials()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model, active: 'service')
    @$("#masterNav").html view.render().el

  gotoEdit: ->
    view = new Mis.Views.XiaoshouServiceProfilesEdit(model: @model)
    @$("div.details_content").html(view.render().el)

  renderMaterials: =>
    @$(".materialList").empty()
    @model.materials.each @addMaterial

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'show')
    @$(".materialList").append view.render().el
