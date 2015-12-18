class Mis.Views.XiaoshouServiceProfilesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/service/profiles/show']

  render: ->
    @$el.html(@template(service: @model))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @renderMaterials()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model, active: 'service')
    @renderChildInto(view, @$("#masterNav"))

  renderMaterials: =>
    @model.materials.each @renderMaterial

  renderMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'show')
    @appendChildTo(view, @$(".materialList"))
