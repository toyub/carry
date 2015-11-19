class Mis.Views.XiaoshouPackagesItem extends Support.CompositeView
  tagName: 'tr'

  template: JST['xiaoshou/packages/item']

  initialize: ->
    @listenTo(@model, 'remove', @leave)

  render: ->
    @$el.html(@template(package: @model, view: @))
    @

  packageUrl: ->
    "#store_packages/" + @model.id
