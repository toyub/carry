class Mis.Views.XiaoshouServiceMaterialsCategory extends Mis.Base.View
  el: '#subCategory'

  template: JST['xiaoshou/service/materials/category']

  render: ->
    @$el.html(@template(categories: @collection))
    @
