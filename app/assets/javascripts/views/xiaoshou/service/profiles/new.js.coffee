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
    'change td.Selection_calculation select.use_mode': 'showUnit'
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
    if $(event.currentTarget).val()
      $.get "/ajax/store_material_categories/#{$(event.currentTarget).val()}/sub_categories", (data) ->
        for category in data
          $("#sub_category").append "<option value='#{category.id}'>#{category.name}</option>"
    @searchMaterials()

  searchMaterials: =>
    $.get("/ajax/store_materials", {primary_category: $("#primary_category").val(), sub_category: $("#sub_category").val(), name: $("#material_name").val()})
      .done(
        (data) ->
          $("table.query_results_table tbody").empty()
          for material in data
            item = "<tr><td>#{material.name}</td><td data-id='#{material.id}' data-unit='#{material.unit}'><input type='checkbox'></td></tr>"
            $("table.query_results_table tbody").append item
      )

  selectMaterials: ->
    $("div.table_list table.selected_table tbody").empty()
    $("table.query_results_table tbody tr input:checked").each(
      ->
        item = "<tr data-id='#{$(@).parent().attr("data-id")}'><td>#{$(@).parent().parent().find('td:first-child').text()}</td>"
        item += "<td class='Selection_calculation'>"
        item += "<select class='width-55 ss use_mode'>"
        item += "<option selected='selected' value='0'>整计</option>"
        item += "<option value='1'>零散</option>"
        item += "</select>"
        item += "<div class='scattered' style='display: none;'>"
        item += "<select class='width-78  font-12'>"
        item += "<option>选择单位</option>"
        item += "<option>#{$(@).parent().attr('data-unit')}</option>"
        item += "</select>"
        item += "<input type='text' placeholder='填写剂量' class='width-55 font-12'>"
        item += "</div>"
        item += "</td>"
        item += "</tr>"
        $("div.table_list table.selected_table tbody").append item
    )

  showUnit: (event) ->
    if $(event.currentTarget).val() == '1'
      $(event.currentTarget).next().show()
    else
      $(event.currentTarget).next().hide()

  addMaterial: ->
    $("div.table_list table.selected_table tbody tr").each(
      ->
        dataId = $(@).attr('data-id')
        if $("#j_related_goods").has("div[data-id=#{dataId}]").size() == 0
          item = "<div data-id='#{dataId}' class='list_content list_tr'>"
          item += "<ul class='list_tr_hover'>"
          item += "<li class='first_td'>#{dataId}</li>"
          item += "<li class='second_td'>#{$(@).find('td:first-child').text()}</li>"
          item += "<li class='third_td'>#{$(@).find('td:last-child select.use_mode option:selected').text()}</li>"
          item += "<li class='forth_td'>领用<span class='delete close'> × </span></li>"
          item += "</ul></div>"
          $("#j_related_goods").append item
    )
    $("div.add_server").hide()
    $("#j_related_goods").show()
