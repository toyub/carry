class Mis.Views.XiaoshouServiceProfilesNew extends Backbone.View
  initialize: ->
    $('#new_store_service_category').validate(
      rules:
        'store_service_category[name]':
          required: true
      messages:
        'store_service_category[name]':
          required: '请输入名称'

      submitHandler: (form) ->
        $(form).find('[type=submit]').attr('disabled', 'disabled')
        $(form).ajaxSubmit(
          success: (responseText, statusText, xhr) ->
            item = "<li data-value='#{responseText.id}'>#{responseText.name}</li>"
            $("div.select ol").prepend(item)
            $("#FloatWindow").fadeOut()
            $("#FloatWindow .FloatContent").slideUp()
            $(form).find('[type=submit]').attr('disabled', false)
          error: (responseOrErrors, statusText, xhr) ->
            if responseOrErrors && responseOrErrors.responseText
              new Mis.Views.ErrorView({el: $(form), attrsWithErrors: JSON.parse(responseOrErrors.responseText).errors}).render()
            $(form).find('[type=submit]').attr('disabled', false)
        )
    )

    $("#new_store_service").validate(
      ignore: []
      rules:
        'store_service[name]': "required"
        'store_service[retail_price]':
          required: true
          number: true
        'store_service[bargain_price]':
          number: true
        'store_service[point]':
          digits: true
        'store_service[store_service_category_id]': "required"
      messages:
        'store_service[name]': "请输入服务名称"
        'store_service[retail_price]':
          required: '请输入零售价'
          number: '零售价必须是数字'
        'store_service[bargain_price]':
          number: '优惠价必须是数字'
        'store_service[point]':
          digits: '积分必须是整数'
        'store_service[store_service_category_id]': "请选择类别"
    )

  el: 'body'

  events:
    'click span.as_select': 'listServiceCategories'
    'click a.add_btn': 'openCategoryForm'
    'click div.j_categories li': 'selectCategory'
    'click i.close-window': 'hideCategoryForm'
    'click input.cancel_btn': 'hideCategoryForm'
    'blur div.select': 'hideSelect'
    'click .j_add_material': 'openMaterialForm'
    'change select#primary_category': 'getSecondCategory'
    'change select#sub_category': 'searchMaterials'
    'click a#search_materials': 'searchMaterials'
    'click table.query_results_table tbody tr input': 'selectMaterials'
    'click div.item_content input.toggleable': 'toggleFavorable'
    'click div.btn_group a.save_btn': 'addMaterial'
    'click div.btn_group a.cancel_btn': 'hideMaterialForm'

  listServiceCategories: ->
    $("div.select").show()

  openCategoryForm: ->
    $("#FloatWindow").fadeIn()
    $("#FloatWindow .FloatContent").slideDown()

  selectCategory: (event) ->
    $("input[id*='service_category_id']").val($(event.currentTarget).attr('data-value'))
    $("div.j_categories span").text($(event.currentTarget).text())
    $(event.currentTarget).parent().parent().hide()

  hideCategoryForm: ->
    $(".err").removeClass("err")
    $(".error_tip").remove()
    $("#FloatWindow").fadeOut()
    $("#FloatWindow .FloatContent").slideUp()

  hideSelect: ->
    $("div.select").hide()

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
    $.get("/ajax/store_materials", {primary_category: $("#primary_category").val(), sub_category: $("#sub_category").val(), name: $("#material_name").val()})

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
      alert("请选择商品")
      false
    else if @nullUnitOrDose().size() > 0
      alert("你选择了零散，却未指定单位或剂量")
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
    else
      $(event.currentTarget).siblings().last().attr('disabled', true)
