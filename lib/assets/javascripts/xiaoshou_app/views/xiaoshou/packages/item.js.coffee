class Mis.Views.XiaoshouPackagesItem extends Backbone.View
  tagName: 'tr'

  template: JST['xiaoshou/packages/item']

  events:
    'click a.name': 'goToPackageShow'

  render: ->
    @$el.html(@template(package: @model))
    @

  goToPackageShow: ->
    Mis.Constants.StorePackageRouter.navigate(@model.url(), trigger: true)
