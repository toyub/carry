class Mis.Views.XiaoshouPackageProfilesForm extends Backbone.View
  className: 'package_descript float-left'

  template: JST['xiaoshou/package_profiles/form']

  render: ->
    @$el.html(@template(package: @model))
    @
