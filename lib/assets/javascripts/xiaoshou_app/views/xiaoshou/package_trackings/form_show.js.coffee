class Mis.Views.XiaoshouPackageTrackingsFormShow extends Backbone.View
  className: 'tracking_create package_card_tracking_create do_list_new_page'

  template: JST['xiaoshou/package_trackings/form_show']

  events:
    'click #closeWithoutSave': 'close'

  render: ->
    @$el.html(@template(tracking: @model))
    @

  open: ->
    @$el.show()

  close: ->
    @undelegateEvents()
    @$el.hide()
