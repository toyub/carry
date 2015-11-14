class Mis.Views.XiaoshouPackagesForm extends Backbone.View
  className: 'package_descript float-left'

  template: JST['xiaoshou/packages/form']

  render: ->
    @$el.html(@template(package: @model))
    @
