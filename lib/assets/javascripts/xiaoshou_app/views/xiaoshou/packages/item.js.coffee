class Mis.Views.XiaoshouPackagesItem extends Backbone.View
  tagName: 'tr'

  template: ['xiaoshou/packages/item']

  render: ->
    @$el.html(@template(package: @model))
