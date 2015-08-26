class Mis.Views.XiaoshouServiceProfilesNew extends Backbone.View
  initialize: ->
    @serviceCategories = new Mis.Collections.StoreServiceCategories(@$('#serviceCategoryList').data('serviceCategories'))
    @serviceCategories.on('add', @addOneServiceCategory, @)
    Backbone.Validation.bind(@,
      valid: (view, attr, selector) ->
        #console.log attr
      invalid: (view, attr, error, selector) ->
        console.log(error)
    )
    @model.on('sync', @handleSuccess, @)

  el: 'body'

  events:
    'click span.as_select': 'listServiceCategories'
    'click a.add_btn': 'openCategoryForm'
    'click div.j_categories li': 'selectCategory'
    'click .j_add_material': 'openMaterialForm'
    'change select#primary_category': 'getSecondCategory'
    'change select#sub_category': 'searchMaterials'
    'click a#search_materials': 'searchMaterials'
    'click table.query_results_table tbody tr input': 'selectMaterials'
    'click div.item_content input.toggleable': 'toggleFavorable'
    'click div.btn_group a.save_btn': 'addMaterial'
    'click div.btn_group a.cancel_btn': 'hideMaterialForm'
    'submit #new_store_service': 'createOnSubmit'
    'click .remove_goods': 'removeGoods'

  removeGoods: ->
    $(event.target).closest('.list_content').remove()

  createOnSubmit: ->
    event.preventDefault()
    @model.clear(silent: true)
    @model.set(@$('#new_store_service').find(':input').filter(() -> $.trim(this.value).length > 0).serializeJSON().store_service)
    @model.save() if @model.isValid(true)

  handleSuccess: ->
    window.location = Routes.edit_xiaoshou_service_setting_path(@model.get('id'))

  listServiceCategories: ->
    if @$("#serviceCategoryList").children().length == 0
      view = new Mis.Views.XiaoshouServiceProfilesCategory(collection: @serviceCategories)
      @$("#serviceCategoryList").html(view.render().el)
    @$("#serviceCategoryList").parent().show()

  addOneServiceCategory: (category) ->
    view = new Mis.Views.XiaoshouServiceProfilesCategory(model: category)
    @$('#serviceCategoryList').prepend(view.render().el)

  openCategoryForm: ->
    model = new Mis.Models.StoreServiceCategory()
    view = new Mis.Views.XiaoshouServiceProfilesCategoryForm(collection: @serviceCategories, model: model)
    @$("#serviceCategory").html(view.render().el)
    view.show()

  selectCategory: (event) ->
    $("input[id*='service_category_id']").val($(event.currentTarget).attr('data-value'))
    $("div.j_categories span").text($(event.currentTarget).text())
    $(event.currentTarget).parent().parent().hide()

  resetForm: =>
    $("div.add_server .item_content input").val("")
    $("#sub_category").html "<option value=''>请选择</option>"
    $("#primary_category option:first-child").attr('selected', true)
    $("#primary_category option:first-child").siblings().attr('selected', false)
    $("div.table_list div.query_results tbody").empty()
    $("div.table_list div.selected tbody").empty()

  openMaterialForm: ->
    @resetForm()
    $("div.add_server").show()
    
  hideMaterialForm: ->
    @resetForm()
    $("div.add_server").hide()

  getSecondCategory: (event) =>
    $("#sub_category").empty()
    $("#sub_category").append "<option value=''>请选择</option>"
    $.get "/ajax/store_material_categories/#{$(event.currentTarget).val()}/sub_categories" if $(event.currentTarget).val()
    @searchMaterials()

  searchMaterials: =>
    $.get("/ajax/store_materials.js", {primary_category: $("#primary_category").val(), sub_category: $("#sub_category").val(), name: $("#material_name").val()})

  selectMaterials: (event) ->
    dataId = $(event.currentTarget).parent().attr('data-id')
    if $(event.currentTarget)[0].checked
      if $("div.table_list table.selected_table tbody").has("tr[data-id=#{dataId}]").size() == 0
        material = {name: $(event.currentTarget).parent().parent().find('td:first-child').text(), id: dataId, unit: $(event.currentTarget).parent().attr('data-unit')}
        view = new Mis.Views.XiaoshouServiceProfilesMaterial(attributes: {'data-id': dataId}, material: material)
        $("div.table_list table.selected_table tbody").append view.render().el
    else
      $("div.table_list table.selected_table tbody tr[data-id=#{dataId}]").remove()

  nullUnitOrDose: =>
    $("#selected tbody tr").filter(
      ->
        $(@).find(".use_mode").val() == '1' && ($(@).find("div.scattered select option:selected").text() == '选择单位' || $(@).find("div.scattered input").val() == '')
    )

  validateMaterialForm: =>
    if $("#selected tbody tr").size() == 0
      ZhanchuangAlert("请选择商品")
      false
    else if @nullUnitOrDose().size() > 0
      ZhanchuangAlert("你选择了零散，却未指定单位或剂量")
      false
    else
      true

  addMaterial: ->
    return unless @validateMaterialForm()
    $("div.table_list table.selected_table tbody tr").each(
      (index) ->
        dataId = $(@).attr('data-id')
        if $("#j_related_goods").has("div[data-id=#{dataId}]").size() == 0
          material = { index: index, id: dataId, name: $(@).find('td:first-child').text(), use_mode: $(@).find("td:last-child select.use_mode").val(), unit: $(@).find("td:last-child select.use_mode option:selected").text(), dose: $(@).find("td:last-child .scattered input").val() }
          view = new Mis.Views.XiaoshouServiceProfilesRelatedMaterial(attributes: {'data-id': dataId}, material: material)
          $("#j_related_goods").append view.render().el
    )
    $("div.add_server").hide()
    $("#j_related_goods").show()
    
  toggleFavorable: (event) ->
    if $(event.currentTarget).siblings().last().attr('disabled') == 'disabled'
      $(event.currentTarget).siblings().last().attr('disabled', false)
      $(event.currentTarget).attr("checked", "checked")
      $(event.currentTarget).val(true)
    else
      $(event.currentTarget).siblings().last().attr('disabled', true)
      $(event.currentTarget).attr("checked", false)
      $(event.currentTarget).val(false)
