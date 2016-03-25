class Mis.Views.XiaoshouServiceProfilesNew extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  initialize: ->
    @validateBinding()

    @listenTo(@model.materials, 'add', @renderMaterials)
    @listenTo(@model, 'sync', @handleSuccess)

  template: JST['xiaoshou/service/profiles/new']

  events:
    'submit #createService': 'createOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click input.toggleable': 'toggleFavorable'
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

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createService").serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true})
    @model.save() if @model.isValid(true)

  openMaterialForm: ->
    categories = Mis.Reqres.getRootMaterialCategoryEntities()
    materials = Mis.Reqres.getConsumableMaterialEntities()
    $.when(categories, materials).done(
      (categories, materials) =>
        view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model, categories: categories, materials: materials)
        @appendChildTo(view, @$(".server_list"))
    )

  renderMaterials: ->
    @$(".materialList").empty()
    @model.materials.each @addMaterial

  addMaterial: (material, index) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model, index: index)
    @appendChildTo(view, @$(".materialList"))
    @$(".materialList").parent().show()

  toggleFavorable: ->
    if $("#bargain_price").attr('disabled') == 'disabled'
      $("#bargain_price").attr('disabled', false)
      $("#favorable").attr("checked", "checked").val(true)
    else
      $("#bargain_price").attr('disabled', true)
      $("#favorable").attr("checked", false).val(false)

  handleSuccess: ->
    @collection.add @model
    @uploadImages()

  rootResource: ->
    "service"

  subResource: ->
    "profiles"

  action: ->
    "new"
