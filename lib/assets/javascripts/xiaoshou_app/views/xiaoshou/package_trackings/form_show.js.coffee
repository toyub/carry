class Mis.Views.XiaoshouPackageTrackingsFormShow extends Mis.Base.View
  className: 'tracking_create package_card_tracking_create do_list_new_page'

  template: JST['xiaoshou/package_trackings/form_show']

  events:
    'click #closeWithoutSave': 'close'

  render: ->
    @$el.html(@template(tracking: @model))
    @$el.show()
    @

  close: ->
    @leave()
