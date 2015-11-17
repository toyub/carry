class Mis.Views.XiaoshouUploadsItem extends Backbone.View
  tagName: 'span'

  template: JST['xiaoshou/uploads/item']

  render: ->
    @$el.html(@template(@model.attributes))
    @
