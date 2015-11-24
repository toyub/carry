class Mis.Views.XiaoshouPackageProfilesItem extends Mis.Base.View
  tagName: 'tr'

  template: JST['xiaoshou/package_profiles/item']

  initialize: ->
    @listenTo(@model, 'remove', @leave)

  render: ->
    @$el.html(@template(package: @model, view: @))
    @

  packageUrl: ->
    "#store_packages/#{@model.id}"
