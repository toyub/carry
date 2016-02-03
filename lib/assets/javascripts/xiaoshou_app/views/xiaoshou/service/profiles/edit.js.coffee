class Mis.Views.XiaoshouServiceProfilesEdit extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  template: JST['xiaoshou/service/profiles/edit']

  initialize: ->
    @validateBinding()
    @listenTo(@model, 'sync', @handleSuccess)
    @listenTo(@model.materials, 'add', @addMaterial)

  events:
    'submit #editStoreService': 'updateOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click #bargain_price_enabled': 'triggerPriceInput'

  render: ->
    @$el.html(@template(service: @model))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @model.materials.each @addMaterial
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model, active: 'service')
    @renderChildInto(view, @$("#masterNav"))

  addMaterial: (material) =>
    @$(".materialList").parent().show()
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model)
    @appendChildTo(view, @$(".materialList"))

  updateOnSubmit: ->
    event.preventDefault()
    console.log($("#editStoreService").serializeJSON())
    @model.set $("#editStoreService").serializeJSON()
    @model.save() if @model.isValid(true)

  openMaterialForm: ->
    view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model)
    @appendChildTo(view, @$(".server_list"))

  triggerPriceInput: (e) ->
    checkbox = $(e.target)
    console.log(checkbox.prop("checked"))
    if (checkbox.prop("checked") == true) 
      checkbox.next("input").removeAttr("disabled") 
    else
      checkbox.next("input").attr("disabled", "disabled")

  handleSuccess: ->
    @uploadImages()

  rootResource: ->
    "service"

  subResource: ->
    "profiles"

  action: ->
    "edit"
