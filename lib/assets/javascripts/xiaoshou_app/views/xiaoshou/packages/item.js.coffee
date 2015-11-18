class Mis.Views.XiaoshouPackagesItem extends Backbone.View
  tagName: 'tr'

  template: JST['xiaoshou/packages/item']

  initialize: ->
    @model.on('remove', @remove, @)

  events:
    'click a.name': 'goToPackageShow'

  render: ->
    @$el.html(@template(package: @model))
    @

  remove: ->
    @$el.remove()
    @undelegateEvents()
    @model.off()

  goToPackageShow: ->
    Mis.Constants.StorePackageRouter.navigate(@model.url(), trigger: true)
