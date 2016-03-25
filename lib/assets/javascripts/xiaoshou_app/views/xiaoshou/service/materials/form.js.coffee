class Mis.Views.XiaoshouServiceMaterialsForm extends Mis.Base.View
  className: 'add_server do_cancel'

  template: JST['xiaoshou/service/materials/form']

  initialize: (options) ->
    @store = Mis.store
    @categories = options.categories
    @materials = options.materials

  events:
    'change #rootCategory': 'renderSubCategory'
    'change #subCategory': 'renderQueryResults'
    'click .query_btn': 'searchOnClick'
    'click .cancel': 'close'
    'click .save_btn': 'addRelatedOnClick'

  render: ->
    @$el.html(@template(service: @model, categories: @categories))
    @

  close: =>
    @leave()

  searchOnClick: ->
    @renderQueryResults()
    $("input[name=materialName]").val("")

  renderSubCategory: (event) ->
    rootId = $(event.target).find("option:selected").attr("value")
    rootCategory = @categories.get rootId
    subCategories = new Mis.Collections.StoreMaterialCategories(rootCategory?.get 'sub_categories')
    view = new Mis.Views.XiaoshouServiceMaterialsCategory
      collection: subCategories
    @renderChild view
    @renderQueryResults()

  renderQueryResults: =>
    if _.isEmpty(@categoryCriterial())
      materials = @materials.models
    else
      materials = @materials.where(@categoryCriterial())
      console.log materials
    materials = _.filter(materials, @queryCriterial)

    @$("#queryResults").empty()
    _.each materials, @addMaterial

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsResult(model: material)
    @appendChildTo(view, @$("#queryResults"))

  queryCriterial: (material) =>
    name = $("input[name=materialName]").val()
    return true unless name
    s(material.get("name")).contains(name)

  categoryCriterial: =>
    rootId = parseInt($("#rootCategory").find("option:selected").attr("value"))
    categoryId = parseInt($("#subCategory").find("option:selected").attr("value"))
    criterial = {}
    criterial = _.extend(criterial, root_category_id: rootId) if rootId
    criterial = _.extend(criterial, category_id: categoryId) if categoryId
    criterial

  addRelatedOnClick: ->
    _.each @materials.selected(), @addOneMaterial
    @close()

  addOneMaterial: (material) =>
    @model.materials.add material
