class Mis.Views.XiaoshouPackageProfilesItem extends Mis.Base.View
  tagName: 'tr'

  template: JST['xiaoshou/package_profiles/item']

  initialize: (options) ->
    @listenTo(@model, 'remove', @leave)
    @index = options.index

  render: ->
    @$el.html(@template(package: @model, view: @))
    @

  packageUrl: ->
    "#store_packages/#{@model.id}"
