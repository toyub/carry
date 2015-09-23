class Mis.Views.XiaoshouServiceProfilesNew extends Backbone.View
  initialize: ->
    @store = window.Store
    @model.materials.on('add', @addMaterial, @)
    @store.serviceCategories.on('add', @addOneCategory, @)
    Backbone.Validation.bind(@)

  template: JST['xiaoshou/service/profiles/new']

  events:
    'submit #createService': 'createOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click span.as_select': 'listServiceCategories'
    'click #addServiceCategory': 'openCategoryForm'

  render: ->
    @$el.html(@template(service: @model))
    @renderServiceCategories()
    @

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createService").serializeJSON()
    @model.save() if @model.isValid(true)
    console.log @model
    console.log 'xxxx'

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
