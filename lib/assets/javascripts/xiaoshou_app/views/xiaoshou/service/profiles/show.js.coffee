class Mis.Views.XiaoshouServiceProfilesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/service/profiles/show']

  events:
    'click .detail': 'showCommissionTemplate'

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

  renderMaterial: (material, index) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'show', index: index)
    @appendChildTo(view, @$(".materialList"))

  rootResource: ->
    "service"

  subResource: ->
    "profiles"

  action: ->
    "show"
