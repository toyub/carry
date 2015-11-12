class Mis.Views.XiaoshouPackageTrackingsForm extends Backbone.View
  className: 'tracking_create package_card_tracking_create do_list_new_page'

  template: JST['xiaoshou/package_trackings/form']

  initialize: ->
    @store_package = @model.package_setting.store_package

  events:
    'click #closeWithoutSave': 'close'
    'click #createTracking': 'createTracking'

  render: ->
    @$el.html(@template(tracking: @model))
    @

  open: ->
    @$el.show()

  close: ->
    @undelegateEvents()
    @$el.hide()

  createTracking: ->
    attrs = @$el.find("input, select, textarea").serializeJSON()
    if @model.isNew()
      @store_package.trackings.create attrs
    else
      @model.save attrs
    @close()
    console.log @model
