class Mis.Views.XiaoshouServiceProfilesMaterialForm extends Backbone.View
  el: '#add_server'

  initialize: ->
    @primaryMaterialCategories = new Mis.Collections.StoreMaterialCategories(@$el.data('primary-material-categories'))

  template: JST['xiaoshou/service/profiles/material_form']

  events:
    'click a.cancel_btn': 'hide'
    'change select#primary_category': 'getSecondCategory'
    'change select#sub_category': 'searchMaterials'
    'click a#search_materials': 'searchMaterials'
    'click table.query_results_table tbody tr input': 'selectMaterials'

  render: ->
    @$el.html(@template(categories: @primaryMaterialCategories))
    @

  selectMaterials: (event) ->
    dataId = $(event.currentTarget).parent().attr('data-id')
    if $(event.currentTarget)[0].checked
      if @$("div.table_list table.selected_table tbody").has("tr[data-id=#{dataId}]").size() == 0
        material = {name: $(event.currentTarget).parent().parent().find('td:first-child').text(), id: dataId, unit: $(event.currentTarget).parent().attr('data-unit')}
        view = new Mis.Views.XiaoshouServiceProfilesMaterial(attributes: {'data-id': dataId}, material: material)
        @$("div.table_list table.selected_table tbody").append view.render().el
    else
      @$("div.table_list table.selected_table tbody tr[data-id=#{dataId}]").remove()


  getSecondCategory: (event) =>
    @$("#sub_category").empty()
    @$("#sub_category").append "<option value=''>请选择</option>"
    $.get "/ajax/store_material_categories/#{@$(event.currentTarget).val()}/sub_categories" if @$(event.currentTarget).val()
    @searchMaterials()

  searchMaterials: =>
    $.get("/ajax/store_materials.js", {primary_category: @$("#primary_category").val(), sub_category: @$("#sub_category").val(), name: @$("#material_name").val()})

  show: ->
    @$el.show()

  hide: ->
    @$el.hide()
