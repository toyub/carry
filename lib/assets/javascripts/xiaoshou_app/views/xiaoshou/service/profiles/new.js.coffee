class Mis.Views.XiaoshouServiceProfilesNew extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  initialize: ->
    @store = window.Store
    @model.materials.on('add', @addMaterial, @)
    @store.serviceCategories.on('add', @addOneCategory, @)
    Backbone.Validation.bind(@)
    @model.on('sync', @handleSuccess, @)
    @model.on('validated:invalid', @invalid, @)

  template: JST['xiaoshou/service/profiles/new']

  events:
    'submit #createService': 'createOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click span.as_select': 'listServiceCategories'
    'click #addServiceCategory': 'openCategoryForm'
    'click input.toggleable': 'toggleFavorable'
    'click li img': 'previewImage'

  render: ->
    @$el.html(@template(service: @model))
    @renderNav()
    @renderUploadTemplate()
    @renderServiceCategories()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model, active: 'service')
    @$("#masterNav").html view.render().el

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createService").serializeJSON()
    @model.save() if @model.isValid(true)

  openMaterialForm: ->
    view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model)
    view.open()

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model)
    @$(".materialList").append view.render().el
    @$(".materialList").parent().show()

  renderServiceCategories: ->
    @store.serviceCategories.each @renderServiceCategory

  renderServiceCategory: (category) =>
    view = new Mis.Views.XiaoshouServiceCategoriesItem(model: category)
    @$("#serviceCategoryList").append view.render().el

  addOneCategory: (category) ->
    view = new Mis.Views.XiaoshouServiceCategoriesItem(model: category)
    @$("#serviceCategoryList").prepend view.render().el
    view.select()

  listServiceCategories: ->
    @$("#serviceCategoryList").parent().show()

  openCategoryForm: ->
    model = new Mis.Models.StoreServiceCategory()
    view = new Mis.Views.XiaoshouServiceCategoriesForm(collection: @store.serviceCategories, model: model)
    view.open()

  toggleFavorable: ->
    if $("#bargain_price").attr('disabled') == 'disabled'
      $("#bargain_price").attr('disabled', false)
      $("#favorable").attr("checked", "checked").val(true)
    else
      $("#bargain_price").attr('disabled', true)
      $("#favorable").attr("checked", false).val(false)

  handleSuccess: ->
    @uploadImages()
    @goToShow()

  goToShow: ->
    view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model)
    $("#bodyContent").html(view.render().el)

  previewImage: (e) ->
    img = new Image()
    img.src = e.target.src
    $("#material_img_preview").html(img)

  invalid: (model, errors) ->
    @handleError(model, errors)

  handleError: (model, responseOrErrors) ->
    console.log responseOrErrors
