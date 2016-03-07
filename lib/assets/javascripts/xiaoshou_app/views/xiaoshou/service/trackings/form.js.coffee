class Mis.Views.XiaoshouServiceTrackingsForm extends Mis.Base.View
  className: 'service_tracking_create tracking_create do_list_new_page'

  template: JST['xiaoshou/service/trackings/form']

  initialize: (options) ->
    @store_service = @model.store_service
    @action = options.action

    @listenTo(@model, 'change', @addTracking)

  events:
    'click .closeWithoutSave': 'close'
    'click #saveTracking': 'saveTracking'

  render: ->
    @$el.html(@template(tracking: @model, view: @))
    @$el.show()
    @

  close: ->
    @leave()

  saveTracking: ->
    @model.save @$el.find("input,select,textarea").serializeJSON()
    @close()

  addTracking: ->
    @store_service.trackings.add @model

  isShow: ->
    @action == 'show'
