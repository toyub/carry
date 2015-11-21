class Mis.Views.XiaoshouServiceSettingsRegularEdit extends Backbone.View

  template: JST['xiaoshou/service/settings/regular_edit']

  render: ->
    @$el.html(@template(setting: @model, store: Mis.store))
    @
