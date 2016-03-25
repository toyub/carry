class Mis.Views.XiaoshouServiceProfilesEdit extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  template: JST['xiaoshou/service/profiles/edit']

  initialize: ->
    @validateBinding()
    @listenTo(@model, 'sync', @handleSuccess)
    @listenTo(@model.materials, 'add', @renderMaterials)

  events:
    'submit #editStoreService': 'updateOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click #bargain_price_enabled': 'triggerPriceInput'
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

  renderMaterials: ->
    @$(".materialList").empty()
    @model.materials.each @addMaterial

  addMaterial: (material, index) =>
    @$(".materialList").parent().show()
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model, index: index)
    @appendChildTo(view, @$(".materialList"))

  updateOnSubmit: ->
    event.preventDefault()
    @model.set $("#editStoreService").serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true})
    @model.save() if @model.isValid(true)

  openMaterialForm: ->
    categories = Mis.Reqres.getRootMaterialCategoryEntities()
    materials = Mis.Reqres.getConsumableMaterialEntities()
    $.when(categories, materials).done(
      (categories, materials) =>
        view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model, categories: categories, materials: materials)
        @appendChildTo(view, @$(".server_list"))
    )

  triggerPriceInput: (e) ->
    checkbox = $(e.target)
    input_bargain_price = $("#bargain_price")
    checkbox.val(checkbox.prop('checked'))
    if checkbox.prop("checked")
      input_bargain_price.prop("disabled", false)
    else
      input_bargain_price.prop("disabled", true)

  handleSuccess: ->
    @uploadImages()

  rootResource: ->
    "service"

  subResource: ->
    "profiles"

  action: ->
    "edit"
