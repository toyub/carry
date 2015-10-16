class Mis.Views.XiaoshouServiceMaterialsCategory extends Backbone.View
  el: '#subCategory'

  template: JST['xiaoshou/service/materials/category']

  render: ->
    @$el.html(@template(categories: @collection))
    @
