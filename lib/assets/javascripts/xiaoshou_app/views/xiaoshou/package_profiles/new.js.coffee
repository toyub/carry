class Mis.Views.XiaoshouPackageProfilesNew extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  template: JST['xiaoshou/package_profiles/new']

  initialize: ->
    @validateBinding()
    @listenTo(@model, 'sync', @handleSuccess)

  events:
    'submit #createPackage': 'createOnSubmit'

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createPackage").serializeJSON()
    @model.save() if @model.isValid(true)

  handleSuccess: ->
    @collection.add @model
    @uploadImages()

  rootResource: ->
    "package"

  subResource: ->
    "profiles"

  action: ->
    "new"
