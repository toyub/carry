class Mis.Views.XiaoshouServiceProfilesNew extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top

  initialize: ->
    Backbone.Validation.bind(@)

    @listenTo(@model.materials, 'add', @addMaterial)
    @listenTo(@model, 'sync', @handleSuccess)
    @listenTo(@model, 'validated:invalid', @invalid)
    @listenTo(@model, 'error', @handleError)

  template: JST['xiaoshou/service/profiles/new']

  events:
    'submit #createService': 'createOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click input.toggleable': 'toggleFavorable'

  render: ->
    @$el.html(@template(service: @model))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model, active: 'service')
    @renderChildInto(view, @$("#masterNav"))

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createService").serializeJSON()
    @model.save() if @model.isValid(true)

  openMaterialForm: ->
    view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model)
    @appendChildTo(view, @$(".server_list"))

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model)
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
    @uploadImages()

  invalid: (model, errors) ->
    @handleError(model, errors)

  handleError: (model, responseOrErrors) ->
    console.log responseOrErrors
