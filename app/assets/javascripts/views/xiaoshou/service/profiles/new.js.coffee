class Mis.Views.XiaoshouServiceProfilesNew extends Backbone.View
  initialize: ->
    @store = window.Store
    @model.materials.on('add', @addMaterial, @)
    @store.serviceCategories.on('add', @addOneCategory, @)
    Backbone.Validation.bind(@)
    @model.on('sync', @handleSuccess, @)

  template: JST['xiaoshou/service/profiles/new']

  events:
    'submit #createService': 'createOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click span.as_select': 'listServiceCategories'
    'click #addServiceCategory': 'openCategoryForm'
    'click input.toggleable': 'toggleFavorable'
    'click a.add_img': 'openImageForm'

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

  toggleFavorable: ->
    if $("#bargain_price").attr('disabled') == 'disabled'
      $("#bargain_price").attr('disabled', false)
      $("#favorable").attr("checked", "checked").val(true)
    else
      $("#bargain_price").attr('disabled', true)
      $("#favorable").attr("checked", false).val(false)

  handleSuccess: ->
    url = @model.url() + '/save_picture'
    @$('#preview_list > img').each () ->
      img = @
      $.ajax(
        type: 'POST'
        url: url
        data:
          img: img.src
        dataType: 'json'
        success: (data) -> console.log data
      )
    window.location = Routes.edit_xiaoshou_service_setting_path(@model.get('id'))

  openImageForm: ->
    view = new Mis.Views.XiaoshouServicePicturesForm()
    view.open()
