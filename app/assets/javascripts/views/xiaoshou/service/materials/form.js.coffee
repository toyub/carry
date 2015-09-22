class Mis.Views.XiaoshouServiceMaterialsForm extends Backbone.View
  el: '#add_server'

  template: JST['xiaoshou/service/materials/form']

  initialize: ->
    @store = window.Store

  events:
    'change #rootCategory': 'renderSubCategory'
    'change #subCategory': 'renderQueryResults'
    'click .query_btn': 'searchOnClick'

  render: ->
    @$el.html(@template(service: @model, store: @store))
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @$el.hide()

  searchOnClick: ->
    @renderQueryResults()
    @$("input[name=name]").val("")

  renderSubCategory: (event) ->
    rootId = $(event.target).find("option:selected").attr("value")
    rootCategory = @store.rootMaterialCategories.get(rootId)
    if rootCategory
      subCategories = rootCategory.subMaterialCategories
    else
      subCategories = new Mis.Collections.StoreMaterialCategories()
    view = new Mis.Views.XiaoshouServiceMaterialsCategory(collection: subCategories)
    view.render()
    @renderQueryResults()

  renderQueryResults: =>
    materials = @store.materials
    if _.isEmpty(@categoryCriterial())
      materials = materials.models
    else
      materials = materials.where(@categoryCriterial())
    materials = _.filter(materials, @queryCriterial)

    @$("#queryResults").empty()
    _.each materials, @addMaterial

  addMaterial: (material) ->
    view = new Mis.Views.XiaoshouServiceMaterialsResult(model: material)
    @$("#queryResults").append view.render().el

  queryCriterial: (material) =>
    name = @$("input[name=name]").val()
    return true unless name
    s(material.get("name")).contains(name)

  categoryCriterial: =>
    rootId = parseInt($("#rootCategory").find("option:selected").attr("value"))
    categoryId = parseInt($("#subCategory").find("option:selected").attr("value"))
    criterial = {}
    criterial = _.extend(criterial, root_category_id: rootId) if rootId
    criterial = _.extend(criterial, category_id: categoryId) if categoryId
    criterial
