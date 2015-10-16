class Mis.Views.XiaoshouServiceCategoriesItem extends Backbone.View

  template: JST['xiaoshou/service/categories/item']

  events:
    'click li': 'select'

  render: ->
    @$el.html(@template(category: @model))
    @

  select: ->
    $("#store_service_category_id").val(@model.get 'id')
    $(".as_select").text(@model.get 'name')
    $("#serviceCategoryList").parent().hide()
