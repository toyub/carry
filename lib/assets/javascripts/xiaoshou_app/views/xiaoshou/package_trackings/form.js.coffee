class Mis.Views.XiaoshouPackageTrackingsForm extends Mis.Base.View
  className: 'tracking_create package_card_tracking_create do_list_new_page'

  template: JST['xiaoshou/package_trackings/form']

  events:
    'click #closeWithoutSave': 'close'
    'click #createTracking': 'createTracking'

  render: ->
    @$el.html(@template(tracking: @model))
    @$el.show()
    @

  close: ->
    @leave()

  createTracking: ->
    attrs = @$el.find("input, select, textarea").serializeJSON()
    if @model.isNew()
      @collection.create attrs
    else
      @model.save attrs
    @close()
