class Mis.Views.XiaoshouPackageItemsForm extends Backbone.View
  el: "#newPackageItem"

  template: JST['xiaoshou/package_items/form']

  initialize: (options) ->
    console.log 123

  events:
    'click #saveAndClose': 'saveOnClick'
    'click #closeWithoutSave': 'close'

  render: ->
    @$el.find("#packageCreateDetails").html(@template(item: @model))
    @

  open: ->
    @render()
    @$el.show()

  saveOnClick: ->
    console.log 123

  close: ->
    @undelegateEvents()
    @$el.hide()
