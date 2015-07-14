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
